#!/bin/bash
# Author: David De Potter
# This script will try to compile your program and test its correctness
# by running it on all the test cases for the current problem.
# The argument is the name of the program to test.
# Example: $ ../../../ctest.sh myprogram.c 

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
CYANBACK="\e[46m"
MAGENTA="\e[35m"
BOLDBLUE="\e[1;34m"
ENDCOLOR="\e[0m"
PASSED=0

if [ $# -eq 0 ]; then
  echo -e "\nNo argument supplied!"
  echo "Usage: $0 myprogram.c"
  exit 1
fi

gcc -O2 -std=c99 -pedantic -Wall -o a.out "$1" -lm

if [[ $? -ne 0 ]]; then
  echo -e "\nCompilation failed."
  exit 1
else
  echo -e "\nProgram successfully compiled as a.out\n"
  
  DIR=./tests
  if [ ! -d "$DIR" ]; then
    echo "Test folder not found!"
    echo "Please make sure you are working from the correct directory."
    exit 1
  fi
  readarray -d '' infiles < <(printf '%s\0' ./tests/*.in | sort -zV)
  len=${#infiles[@]}
  if [ $len -eq 0 ]; then
    echo "No test cases found!"
    exit 1
  fi
  
  if [ -t 1 ]; then echo -e "${CYANBACK}  ==:: TEST RESULTS ::==  ${ENDCOLOR}"
  else echo "==:: TEST RESULTS ::=="; fi
  echo
  
  for infile in "${infiles[@]}"; do
    if [ -t 1 ]; then echo -e "${BOLDBLUE}Test ${infile:8} ${ENDCOLOR}"
    echo -e "${BOLDBLUE}---------- ${ENDCOLOR}"
    else echo -e "Test $infile\n---------- "; fi
    outfile="${infile%.*}.out"
    if [ ! -f "$outfile" ]; then
      echo -e "Test file $outfile not found!\n"
      continue
    else
      dif="$(diff "${infile%.*}.out" <(./a.out < "$infile"))"
      if [ -n "$dif" ]; then
        if [ -t 1 ]; then echo -e "${RED}Test failed.${ENDCOLOR}
        \nDifference : ${RED}$dif${ENDCOLOR}\n"
        else echo -e "FAILED.\nDifference : $dif\n"; fi
      else
        if [ -t 1 ]; then echo -e "${GREEN}PASSED!${ENDCOLOR}\n"
        else echo -e "PASSED!\n"; fi
        PASSED=$((PASSED + 1))
      fi
    fi
  done

  if [ $PASSED -eq $len ]; then
    if [ -t 1 ]; then echo -e "${GREEN}You have passed all tests! \(ᵔᵕᵔ)/${ENDCOLOR}"
    else echo "All tests passed!"; fi
  elif [ $PASSED -eq $(($len-1)) ]; then 
    if [ -t 1 ]; then echo -e "${MAGENTA}You have passed $PASSED out of $len tests."
    echo -e "Almost there...! (◎_◎)${ENDCOLOR}"
    else echo -e "Passed $PASSED out of $len tests."; fi
  else    
    if [ -t 1 ]; then echo -e "${MAGENTA}You have passed $PASSED out of $len tests. 
    (._.)${ENDCOLOR}"
    else echo "Passed $PASSED out of $len tests."; fi
  fi
  echo
fi

# Clean exit with status 0
exit 0

