/* file: prob2.c
   author: David De Potter
   description: IP mid2019, problem 2, balanced numbers
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks whether n is a balanced number
int isBalancedNumber (int n) {
  int digit, evenDigitSum = 0, oddDigitSum = 0;

  do {
    digit = n % 10;
    if (digit % 2 == 0) evenDigitSum += digit;
    else oddDigitSum += digit;
    n /= 10;
  } while (n);

  return evenDigitSum == oddDigitSum;
}

//=================================================================

int main() {
  int n;
  
  assert(scanf("%d", &n) == 1);

  printf(isBalancedNumber(n) ? "YES\n" : "NO\n");
  
  return 0;
}
