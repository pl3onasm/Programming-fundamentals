/* file: prob2.c
   author: David De Potter
   description: IP mid2019 resit, problem 2,
   divisible by 11
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================

int main() {
  int digit, pos = 1, evenSum = 0, oddSum = 0, ch;

  while ((ch = getchar()) != EOF && ch != '\n') {
    digit = ch - '0';
    if (pos % 2) oddSum += digit;
    else evenSum += digit;
    ++pos;
  }

  printf ((oddSum - evenSum) % 11 ? "NO\n" : "YES\n");

  return 0;
}
