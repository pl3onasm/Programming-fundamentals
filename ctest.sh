#!/bin/bash
# Author: David De Potter
# Tested on Ubuntu 24.04 LTS, using GCC 14.2.0, and Valgrind 3.22.0.

#===================================================================#
# ctest.sh                                                          #
#                                                                   #
# Compiles a user's C program and runs it on all test cases         #
# found in a test folder (default: ./tests).                        #
#                                                                   #
# Each test case consists of:                                       #
#   - <name>.in   input                                             #
#   - <name>.out  expected output                                   #
#                                                                   #
# If the user's program includes a clib header, the script will:    #
#   - infer the library root                                        #
#   - build libclib.a if missing                                    #
#   - compile and link against build/lib/libclib.a                  #
#                                                                   #
# Options:                                                          #
#   --show-diff, -d                                                 #   
#     Show first 5 lines of expected vs actual output for each      #
#     failed correctness test.                                      #
#                                                                   #   
#   --show-vg, -e                                                   #
#     Show valgrind error details for each failed valgrind check.   #
#                                                                   #
#   --valgrind, -v                                                  #
#     Run valgrind on all test cases (summary stays clean unless    #
#     --show-vg or -e is also enabled).                             #
#                                                                   #
#   --help, -h                                                      #
#     Show this help message.                                       #
#                                                                   #
# Examples:                                                         #
#   ./ctest.sh prog.c                                               #             
#   ./ctest.sh prog.c -d                                            #
#   ./ctest.sh prog.c -v                                            #
#   ./ctest.sh prog.c -v -e                                         #
#   ./ctest.sh prog.c -d -v -e                                      #
#                                                                   #
#===================================================================#


#-------------------------------------------------------------------#
#    Colors                                                         #
#                                                                   #            
# Behavior depends on whether stdout is a terminal:                 #
#   - If stdout is a terminal: use ANSI colors                      #
#   - Otherwise: disable colors (so redirected output is clean)     #
#-------------------------------------------------------------------#

if [ -t 1 ]; then
  CYAN=$'\033[1;36m'
  BBLUE=$'\033[1;34m'
  BLUE=$'\033[0;34m'
  GREEN=$'\033[32m'
  RED=$'\033[31m'
  MAGENTA=$'\033[35m'
  NC=$'\033[0m'
else
  CYAN=""
  BBLUE=""
  BLUE=""
  GREEN=""
  RED=""
  MAGENTA=""
  NC=""
fi


#-------------------------------------------------------------------#
#    Helper functions                                               #
#-------------------------------------------------------------------#

function die {
  echo -e "\n${RED}Error:${NC} $*"
  exit 1
}

function print_help {
  cat <<EOF

Usage:
  $0 <program.c> [options]

Description:
  Compiles <program.c> and runs it against all test cases in ./tests
  (or a folder you provide if ./tests is not found).

Options:
  --show-diff, -d
      Show the first 5 lines of expected vs actual output for each
      failed correctness test.

  --show-vg, -e
      Show valgrind error details for each failed valgrind check.

  --valgrind, -v
      Run valgrind on all test cases. Output remains a clean summary
      unless --show-vg or -e is enabled.

  --help, -h
      Show this message and exit.

Examples:
  $0 prog.c
  $0 prog.c --show-diff
  $0 prog.c --valgrind
  $0 prog.c --valgrind --show-vg 
  $0 prog.c --show-diff --valgrind --show-vg

EOF
}


#-------------------------------------------------------------------#
#    Parse arguments                                                #             
#-------------------------------------------------------------------#

[ $# -ge 1 ] || { print_help; exit 1; }

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  print_help
  exit 0
fi

PROG="$1"
shift

SHOW_DIFF=0
SHOW_VG=0
DO_VALGRIND=0

for arg in "$@"; do
  case "$arg" in
    --show-diff|-d) SHOW_DIFF=1 ;;
    --show-vg|-e)   SHOW_VG=1 ;;
    --valgrind|-v)  DO_VALGRIND=1 ;;
    --help|-h)      print_help; exit 0 ;;
    *)
      echo -e "\nUnknown option: $arg"
      print_help
      exit 1
      ;;
  esac
done


#-------------------------------------------------------------------#
#    Sanity checks                                                  #
#-------------------------------------------------------------------#

[ -f "$PROG" ] || die "File not found: $PROG"
command -v gcc >/dev/null 2>&1 \
        || die "gcc not found. Please install gcc."

if [ $DO_VALGRIND -eq 1 ]; then
  command -v valgrind >/dev/null 2>&1 || \
    die "valgrind not found. Install it or run without --valgrind."
fi


#-------------------------------------------------------------------#
#    Compile program (with optional clib linking)                   #
#-------------------------------------------------------------------#

function compile_program {
  local include_line header hdr_dir include_dir libroot liba

  # Detect clib usage:
  # any non-commented include containing ".../include/clib/<...>.h"
  RE='^[[:space:]]*#include[[:space:]]*["<][^">]*include/clib/[^">]+\.h[">]'

  include_line=$(grep -hE "$RE" "$PROG" | head -n 1)

  if [ -n "$include_line" ]; then
  header=$(
    sed -E \
      's/^[[:space:]]*#include[[:space:]]*["<]([^">]+)[">].*$/\1/'\
      <<< "$include_line"
  )

    hdr_dir=$(dirname "$header")           # .../include/clib
    include_dir=$(dirname "$hdr_dir")      # .../include
    libroot=$(dirname "$include_dir")      # .../Functions

    [ -f "$libroot/include/clib/clib.h" ] \
      || die "clib not found for include path: $header"
    [ -d "$libroot/src" ]                 \
      || die "clib src/ not found in: $libroot"
    [ -f "$libroot/Makefile" ]            \
      || die "Makefile not found in: $libroot"

    liba="$libroot/build/lib/libclib.a"

    # Build libclib.a only if needed
    if [ ! -f "$liba" ]; then
      echo -e "\nBuilding clib static library..."
      make -C "$libroot" lib >/dev/null \
              || die "Building clib failed."
    fi

    [ -f "$liba" ] || die "Static library not found: $liba"

    echo -e "\nCompiling the program with library clib..."
    gcc -O2 -std=c99 -pedantic -Wall -o a.out \
      -I"$libroot/include" "$PROG" "$liba" -lm \
      || die "Compilation failed."
  else
    echo -e "\nCompiling the program..."
    gcc -O2 -std=c99 -pedantic -Wall -o a.out "$PROG" -lm \
      || die "Compilation failed."
  fi

  echo -e "\nProgram successfully compiled as a.out"
}

compile_program


#-------------------------------------------------------------------#
#    Locate tests directory                                         #
#-------------------------------------------------------------------#

DIR="./tests"
while [ ! -d "$DIR" ]; do
  echo -e "\nCould not find $DIR"
  echo "Please provide a test folder (Enter to quit):"
  read -r DIR
  [ -n "$DIR" ] || {
    echo "Compiled program not tested."
    exit 0
  }
done


#-------------------------------------------------------------------#
#    Load test cases                                                #
#-------------------------------------------------------------------#

readarray -d '' INFILES < <(printf '%s\0' "$DIR"/*.in | sort -zV)
LEN=${#INFILES[@]}
[ $LEN -gt 0 ] || die "No test cases found in $DIR"


#-------------------------------------------------------------------#
#    Output header                                                  #
#-------------------------------------------------------------------#

echo -e "${CYAN}\n┌────────────────────────┐${NC}"
echo -e "${CYAN}│     ${BBLUE} TEST RESULTS      ${CYAN}│${NC}"  
echo -e "${CYAN}└────────────────────────┘\n${NC}"


#-------------------------------------------------------------------#
#    Diff summary: show first 5 lines                               #
#-------------------------------------------------------------------#

function show_diff_summary {
  local exp_file="$1"
  local got_file="$2"

  echo -e "         ${GREEN}Expected:${NC}"
  if [ -s "$exp_file" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
      echo -e "         ${GREEN}${line}${NC}"
    done < <(head -n 5 "$exp_file")
  else
    echo "         (empty)"
  fi

  echo
  echo -e "         ${RED}Actual:${NC}"
  if [ -s "$got_file" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
      echo -e "         ${RED}${line}${NC}"
    done < <(head -n 5 "$got_file")
  else
    echo "         (empty)"
  fi
  echo
}


#-------------------------------------------------------------------#
#    Valgrind reporting                                             #
#-------------------------------------------------------------------#

function valgrind_passed {
  local out="$1"
  local c1 c2
  c1=$(echo "$out" | grep -c "in use at exit: 0 bytes in 0 blocks")
  c2=$(echo "$out" | grep -c "0 errors from 0 contexts")
  [[ $c1 -ne 0 && $c2 -ne 0 ]]
}

function show_valgrind_details {
  local out="$1"
    # Key summary lines
  echo "$out" | grep -E "==.*(HEAP SUMMARY|LEAK SUMMARY|\
    'ERROR SUMMARY|in use at exit:|definitely lost:|\
    'indirectly lost:|possibly lost:|still reachable:)"\
    | head -n 40 | sed 's/^/ /'

    # First few invalid access messages (if present)
  local inv
  inv=$(echo "$out" | grep -E "==.*(Invalid read|Invalid write|\
    Use of uninitialised value|Conditional jump|Invalid free)"\
    | head -n 12)

  if [ -n "$inv" ]; then
    echo
    echo "         Details:"
    echo "$inv" | sed 's/^/ /'
  fi
}


#-------------------------------------------------------------------#
#    Run tests                                                      #
#-------------------------------------------------------------------#

PASS_OK=0
PASS_VG=0

for INFILE in "${INFILES[@]}"; do
  NAME="${INFILE##*/}"
  DISPLAY_NAME="$NAME"
  if [[ "$NAME" =~ ^(.*[^0-9])?([0-9]+)(\.in)$ ]]; then
    PAD=$(printf "%02d" "${BASH_REMATCH[2]}")
    DISPLAY_NAME="${BASH_REMATCH[1]}${PAD}${BASH_REMATCH[3]}"
  fi

  OUTFILE="${INFILE%.*}.out"

  if [ ! -f "$OUTFILE" ]; then
    echo -e "   Test $DISPLAY_NAME:    ${RED}NA${NC} "
    echo -e "     output file ${OUTFILE##*/} not found\n"
    continue
  fi

  # Run program, capture output to a temp file 
  TMP_OUT=$(mktemp)
  ./a.out < "$INFILE" > "$TMP_OUT"
  RC=$?

  # Correctness check
  if [ $RC -ne 0 ]; then
    echo -e "   Test $DISPLAY_NAME:    ${RED}FAIL${NC} "
    echo -e "   (program exited with code $RC)"
    if [ $SHOW_DIFF -eq 1 ]; then
      echo "   (no diff shown: program did not produce "
      echo "   normal output)"
    fi
  else
    TMP_EXP=$(mktemp)
    TMP_GOT=$(mktemp)

    cp "$OUTFILE" "$TMP_EXP"
    cp "$TMP_OUT" "$TMP_GOT"

      # Add a final newline if missing, so that absence of final 
      # newline does not count as a difference.
    if [ -s "$TMP_EXP" ]; then
      LAST=$(tail -c 1 "$TMP_EXP" | od -An -t u1 | tr -d ' ')
      if [ "$LAST" != "10" ]; then
        echo >> "$TMP_EXP"
      fi
    fi

    if [ -s "$TMP_GOT" ]; then
      LAST=$(tail -c 1 "$TMP_GOT" | od -An -t u1 | tr -d ' ')
      if [ "$LAST" != "10" ]; then
        echo >> "$TMP_GOT"
      fi
    fi

    DIF="$(diff -Z "$TMP_EXP" "$TMP_GOT")"

    rm -f "$TMP_EXP" "$TMP_GOT"
    if [ -n "$DIF" ]; then
      echo -e "   Test $DISPLAY_NAME:    ${RED}FAIL${NC}"
      if [ $SHOW_DIFF -eq 1 ]; then
        echo
        echo "     Output details:"
        show_diff_summary "$OUTFILE" "$TMP_OUT"
      fi
    else
      echo -e "   Test $DISPLAY_NAME:    ${GREEN}PASS${NC}"
      PASS_OK=$((PASS_OK + 1))
    fi
  fi

  rm -f "$TMP_OUT"

  # Optional valgrind pass
  if [ $DO_VALGRIND -eq 1 ]; then
    VG_OUT=$(valgrind \
      --leak-check=full \
      --show-leak-kinds=all \
      --track-origins=yes \
      ./a.out < "$INFILE" 2>&1 >/dev/null)

    if valgrind_passed "$VG_OUT"; then
      echo -e "     Valgrind:    ${BLUE}PASS${NC}"
      PASS_VG=$((PASS_VG + 1))
    else
      echo -e "     Valgrind:    ${RED}FAIL${NC}"
      if [ $SHOW_VG -eq 1 ]; then
        echo
        echo "     Valgrind details:"
        show_valgrind_details "$VG_OUT"
      fi
    fi
  fi

  echo
done


#-------------------------------------------------------------------#
#    Output final summary                                           #
#-------------------------------------------------------------------#

TOTAL=$LEN

echo -e "──────────────────────────\n"
CORR_LINE=$(printf "%-16s %2d/%d" "   Correctness: " "$PASS_OK" \
            "$TOTAL")
echo -e "${MAGENTA}${CORR_LINE}${NC}"

if [ $DO_VALGRIND -eq 1 ]; then
  VG_LINE=$(printf "%-16s %2d/%d" "   Valgrind:    " "$PASS_VG" \
            "$TOTAL")
  echo -e "${MAGENTA}${VG_LINE}${NC}"
fi

echo -e "\n"
exit 0
