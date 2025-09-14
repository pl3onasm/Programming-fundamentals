/* file: prob2.c
* author: David De Potter
* description: IP mid2019 resit, problem 2,
* divisible by 11
*/

#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  int digit, pos=1, evenSum=0, oddSum=0;
  char c;

  while ((c = getchar()) != EOF && c != '\n') {
    digit = c - '0';
    if (pos % 2 != 0) oddSum += digit;
    else evenSum += digit;
    pos++;
  }
  printf ((oddSum - evenSum) % 11 ? "NO\n" : "YES\n");
  return 0;
}
