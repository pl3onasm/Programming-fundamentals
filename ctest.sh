#!/bin/bash
# Author: David De Potter
# Developed and tested on Ubuntu 22.04 LTS, with GNU bash, version 5.1.16

# This script will try to compile your program and test its correctness
# by running it on all test cases for the current problem.
# It will also perform a test for memory leaks.
# The argument is the name of the program to test.
# Example: $ ../../../ctest.sh myprogram.c 
# If the program includes the functions library, it will be compiled with it.


# Define some colors for output
function cyan {
  printf "\e[1;36m$@\e[0m"
}
function blue {
  printf "\e[1;34m$@\e[0m"
}
function red {
  printf "\e[31m$@\e[0m"
}
function green {
  printf "\e[32m$@\e[0m"
}
function magenta {
  printf "\e[35m$@\e[0m"
}

PASSED=0  # number of passed tests

# Check if an argument, the program to test, is provided
if [ $# -eq 0 ]; then
  echo -e "\nNo argument supplied!"
  echo "Usage: $0 myprogram.c"
  exit 1
fi

# Check if compiler is installed
if ! [ -x "$(command -v gcc)" ]; then
  echo -e "\nCompiler not found! Please install gcc."
  exit 1
fi

# Extract the include line for clib.h from the program if it exists
# it should not be commented out
INCLUDE=$(grep -E "^#include[ /.\"a-zA-Z0-9]*clib.h" "$1")

if [ -n "$INCLUDE" ]; then
  # Extract the path to the clib library and remove 'clib.h' at the end
  LIBPATH=$(echo "$INCLUDE" | cut -d '"' -f 2 | rev | cut -d '/' -f 2- | rev)
  # Check if the library path is valid and contains clib.h
  if [ -d "$LIBPATH" ] && [ -f "$LIBPATH/clib.h" ]; then
    echo -e "\nClib library found in $LIBPATH"
  else
    echo -e "\nClib library not found in $LIBPATH"
    exit 1
  fi
  # Compile the program with the library included
  echo -e "\nCompiling the program with library clib..."
  gcc -O2 -std=c99 -pedantic -Wall -o a.out "$1" "$LIBPATH"/*.c -lm
else
  # Compile the program without the library
  gcc -O2 -std=c99 -pedantic -Wall -o a.out "$1" -lm
fi

# Check if compilation was successful
if [[ $? -ne 0 ]]; then
  echo -e "\nCompilation failed."
  exit 1
fi

echo -e "\nProgram successfully compiled as a.out"

DIR=./tests   # default test folder
# If ./tests does not exist, ask for a test folder or exit
while [ ! -d "$DIR" ]; do
  echo -e "\nCould not find $DIR"
  echo "Please provide a test folder (Enter to quit):"
  read -r DIR
  if [ -z "$DIR" ]; then
    echo "Compiled program not tested."
    exit 0
  fi
done

# Get all the input files from the test folder in DIR and sort them
readarray -d '' INFILES < <(printf '%s\0' "$DIR"/*.in | sort -zV)
LEN=${#INFILES[@]}
if [ $LEN -eq 0 ]; then
  echo "No test cases found!"
  exit 1
fi

echo

# Print header for test results
if [ -t 1 ]; then
  echo -e $(cyan "┌──────────────────────────┐") 
  echo -e "$(cyan "│")       $(blue "TEST RESULTS")       $(cyan "│")"
  echo -e $(cyan "└──────────────────────────┘")
else
  echo -e "┌──────────────────────────┐" 
  echo -e "│       TEST RESULTS       │"
  echo -e "└──────────────────────────┘"
fi

echo

# Compare the output of the program with the expected output
for INFILE in "${INFILES[@]}"; do
  if [ -t 1 ]; then 
    echo -e $(blue "Test ${INFILE##*/}")  # print filename without path   
    echo -e $(blue "----------")
  else echo -e "Test ${INFILE##*/}\n---------- "; fi
  OUTFILE="${INFILE%.*}.out"     # replace .in with .out
  if [ ! -f "$OUTFILE" ]; then
    echo -e "Test file $OUTFILE not found!\n"
    continue
  else
    # run the program with the input file
    OUTPUT=$(./a.out < "$INFILE")  
    # compare the output with the expected output
    DIF="$(diff -Z "$OUTFILE" <(echo "$OUTPUT"))" 

    if [ -n "$DIF" ]; then
      # test failed if there are differences
      if [ -t 1 ]; then echo -e $(red "Failed.")
      else echo -e "Failed."; fi
      
      EXP=0; GOT=0  # number of expected and actual lines in the diff

      # print the first 5 mismatches
      echo "$DIF" | (while [[ $EXP -lt 5 ]] && read -r line; do
        if [[ $line == "<"* ]]; then
          if [ -t 1 ]; then echo -e "  $(green "$line")"
          else echo -e "  $line"; fi
          EXP=$((EXP + 1))
        elif [[ $line == ">"* ]]; then  
          if [ -t 1 ]; then echo -e "  $(red "$line")"
          else echo -e "  $line"; fi
          GOT=$((GOT + 1))
        elif [[ $line == *"c"* ]]; then 
          OUT=$(echo "$line" | cut -d "c" -f 1)
          OUT=$(echo "$OUT" | sed 's/,/-/g')
          echo -e "\n  line "$OUT""
        fi
      done
      while [[ $GOT -ne $EXP ]] && read -r line; do
        # get next > lines until they match the number of < lines
        if [[ $line == ">"* ]]; then  
          if [ -t 1 ]; then echo -e "  $(red "$line")"
          else echo -e "  $line"; fi
          GOT=$((GOT + 1))
        fi
      done
      # indicate if there are more mismatches than shown
      LINES=$(echo "$DIF" | grep -c "<")
      if [[ $LINES -gt EXP ]]; then
        echo -e "\n  ... ($((LINES - EXP)) more)"
      fi
      echo)
    else
      # test passed
      if [ -t 1 ]; then 
        echo -e $(green "PASSED!")
        echo
      else echo -e "PASSED!\n"; fi
      PASSED=$((PASSED + 1))
    fi
  fi
done

# Check for memory issues with valgrind
if [ -t 1 ]; then 
  echo -e $(blue "Valgrind test")
  echo -e $(blue "------------- ")
else echo -e "Valgrind test\n------------- "; fi

if ! [ -x "$(command -v valgrind)" ]; then
  echo -e "Test failed. Valgrind not installed.\n"
else
  TEST=$(valgrind ./a.out < "${INFILES["$((LEN-1))"]}" 2>&1 >/dev/null)\
  CHECK1=$(echo "$TEST" | grep -c "in use at exit: 0 bytes in 0 blocks")
  CHECK2=$(echo "$TEST" | grep -c "0 errors from 0 contexts")
  if [[ $CHECK1 -ne 0 && $CHECK2 -ne 0 ]]; then
    if [ -t 1 ]; then echo -e $(green "PASSED!")
    else echo -e "PASSED!"; fi
    PASSED=$((PASSED + 1))
  else
    if [ -t 1 ]; then echo -e $(red "Failed.")
      if [ $CHECK1 -eq 0 ]; then echo -e $(red "Not all memory freed."); fi
      if [ $CHECK2 -eq 0 ]; then echo -e $(red "Memory errors detected."); fi
    else echo -e "Failed."
      if [ $CHECK1 -eq 0 ]; then echo -e "Not all memory freed."; fi
      if [ $CHECK2 -eq 0 ]; then echo -e "Memory errors detected."; fi
    fi
  fi
  echo
fi

LEN=$((LEN + 1))  # Add 1 for valgrind test

# Print final result
if [ $PASSED -eq $LEN ]; then
  if [ -t 1 ]; then echo -e $(green "Passed all tests! \(ᵔᵕᵔ)/")
  else echo "All tests passed!"; fi
elif [ $PASSED -eq $(($LEN-1)) ]; then 
  if [ -t 1 ]; then echo -e $(magenta "Passed $PASSED out of $LEN tests.")
  echo -e $(magenta "Almost there...! (◎_◎)")
  else echo -e "Passed $PASSED out of $LEN tests."; fi
else    
  if [ -t 1 ]; then echo -e $(magenta "Passed $PASSED out of $LEN tests. 
  (._.)")
  else echo "Passed $PASSED out of $LEN tests."; fi
fi
echo

# Clean exit with status 0
exit 0

