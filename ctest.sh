#!/bin/bash
# Author: David De Potter
# This script can be used to compile and test the correctness of your program.
# The argument is the name of the program to test.
# Example: ./ctest.sh myprog.c

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
CYANBACK="\e[46m"
MAGENTA="\e[105m"
BOLDBLUE="\e[1;34m"
ENDCOLOR="\e[0m"
PASSED=0
TESTS=0

gcc -O2 -std=c99 -pedantic -Wall -o a.out "$1" -lm

if [[ $? -ne 0 ]]; then
  echo
  echo "Compilation failed."
  exit 1
else
  readarray -d '' infiles < <(printf '%s\0' *.in | sort -zV)
  len=${#infiles[@]}
  echo
  echo "Program succesfully compiled as a.out"
  echo
  if [ -t 1 ]; then echo -e "${CYANBACK}==:: TEST RESULTS ::==${ENDCOLOR}"
  else echo "==:: TEST RESULTS ::=="; fi
  echo
  for infile in "${infiles[@]}"; do
    if [ -t 1 ]; then echo -e "${BOLDBLUE}Test $infile ${ENDCOLOR}"
    echo -e "${BOLDBLUE}---------- ${ENDCOLOR}"
    else echo -e "Test $infile\n---------- "; fi
    ./a.out < "$infile" > "${infile%.*}.res"
    dif="$(diff "${infile%.*}.out" "${infile%.*}.res")"
    if [ -n "$dif" ]; then
      if [ -t 1 ]; then echo -e "${RED}Test failed.${ENDCOLOR}\nDifference : ${RED}$dif${ENDCOLOR}\n"
      else echo -e "Test failed.\nDifference : $dif\n"; fi
    else
      if [ -t 1 ]; then echo -e "${GREEN}TEST OK!${ENDCOLOR}\n"
      else echo -e "TEST OK!\n"; fi
      PASSED=$((PASSED + 1))
    fi
  done
  rm -rf *.res
  if [ $PASSED -eq $len ]; then
    if [ -t 1 ]; then echo -e "${GREEN}All tests passed!${ENDCOLOR}"
    else echo "All tests passed!"; fi
  else
    if [ -t 1 ]; then echo -e "${RED}$PASSED out of $len tests passed.${ENDCOLOR}"
    else echo "$PASSED out of $len tests passed."; fi
  fi
  echo
  
fi

# Clean exit with status 0
exit 0

