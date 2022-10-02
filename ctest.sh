#!/bin/bash
# Author: David De Potter
# This script can be used to compile and test the correctness of your program.
# The argument is the name of the program to test.
# Example: ./ctest.sh myprog.c

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
CYANBACK="\e[46m"
MAGENTA="\e[35m"
BOLDBLUE="\e[1;34m"
ENDCOLOR="\e[0m"

gcc -O2 -std=c99 -pedantic -Wall -o a.out "$1" -lm

if [[ $? -ne 0 ]]; then
  echo
  echo "Compilation failed."
  exit 1
else
  readarray -d '' infiles < <(printf '%s\0' *.in | sort -zV)
  echo
  echo "Program succesfully compiled as a.out"
  echo
  echo -e "${CYANBACK}==:: TEST RESULTS ::==${ENDCOLOR}"
  echo
  for infile in "${infiles[@]}"; do
    echo -e "${BOLDBLUE}Test $infile ${ENDCOLOR}"
    echo -e "${BOLDBLUE}---------- ${ENDCOLOR}"
    echo "Input:"
    cat "$infile"
    echo "Output:"
    ./a.out < "$infile" > "${infile%.*}.res"
    cat "${infile%.*}.res"
    dif="$(diff "${infile%.*}.out" "${infile%.*}.res")"
    if [ -n "$dif" ]; then
      echo -e "Difference : ${RED}$dif${ENDCOLOR}\n"
    else
      echo -e "Result:\n${GREEN}TEST OK!${ENDCOLOR}\n"
    fi
    echo
  done
  rm -rf *.res
fi

# Clean exit with status 0
exit 0

