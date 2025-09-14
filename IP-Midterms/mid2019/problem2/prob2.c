/* file: prob2.c
* author: David De Potter
* description: IP mid2019, problem 2, balanced numbers
*/

#include <stdio.h>
#include <stdlib.h>

int isBalancedNumber (int n) {
  /* returns 1 if n is a balanced number,
   * otherwise returns 0 */
  int digit, evenDigitSum = 0, oddDigitSum = 0;
  while (n) {
    digit = n % 10;
    if (digit % 2 == 0) evenDigitSum += digit;
    else oddDigitSum += digit;
    n /= 10;
  }
  return (evenDigitSum == oddDigitSum);
}

int main(int argc, char *argv[]) {
  int n;
  (void)! scanf("%d", &n);
  printf(isBalancedNumber(n) ? "YES\n" : "NO\n");
  return 0;
}
