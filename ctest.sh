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
PASSED=0

gcc -O2 -std=c99 -pedantic -Wall -o a.out "$1" -lm

if [[ $? -ne 0 ]]; then
  echo
  echo "Compilation failed."
  exit 1
else
  readarray -d '' infiles < <(printf '%s\0' *.in | sort -zV)
  len=${#infiles[@]}
  echo
  echo "Program successfully compiled as a.out"
  echo
  if [ -t 1 ]; then echo -e "${CYANBACK}==:: TEST RESULTS ::==${ENDCOLOR}"
  else echo "==:: TEST RESULTS ::=="; fi
  echo
  for infile in "${infiles[@]}"; do
    if [ -t 1 ]; then echo -e "${BOLDBLUE}Test $infile ${ENDCOLOR}"
    echo -e "${BOLDBLUE}---------- ${ENDCOLOR}"
    else echo -e "Test $infile\n---------- "; fi
    dif="$(diff "${infile%.*}.out" <(./a.out < "$infile"))"
    if [ -n "$dif" ]; then
      if [ -t 1 ]; then echo -e "${RED}Test failed.${ENDCOLOR}\nDifference : ${RED}$dif${ENDCOLOR}\n"
      else echo -e "FAILED.\nDifference : $dif\n"; fi
    else
      if [ -t 1 ]; then echo -e "${GREEN}PASSED!${ENDCOLOR}\n"
      else echo -e "PASSED!\n"; fi
      PASSED=$((PASSED + 1))
    fi
  done
  if [ $PASSED -eq $len ]; then
    if [ -t 1 ]; then echo -e "${GREEN}You have passed all tests! \(ᵔᵕᵔ)/${ENDCOLOR}"
    else echo "All tests passed!"; fi
  elif [ $PASSED -eq $(($len-1)) ]; then 
    if [ -t 1 ]; then echo -e "${MAGENTA}You have passed $PASSED out of $len tests. Almost there...! (◎_◎)${ENDCOLOR}"
    else echo -e "Passed $PASSED out of $len tests."; fi
  else    
    if [ -t 1 ]; then echo -e "${MAGENTA}You have passed $PASSED out of $len tests. (._.)${ENDCOLOR}"
    else echo "Passed $PASSED out of $len tests."; fi
  fi
  echo
fi

# Clean exit with status 0
exit 0

