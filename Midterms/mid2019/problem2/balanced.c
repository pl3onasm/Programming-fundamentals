/* file: balanced.c
* author: David De Potter
* description: IP mid2019, problem 2, balanced numbers
*/

#include <stdio.h>
#include <stdlib.h>

int countDigits (int n) {
  /* returns length of integer n */
  int count=0;

  while (n != 0) {
    count++;
    n /= 10;
  }
  return count;
}

int isBalancedNumber (int n, int len) {
  /* returns 1 if n is a balanced number,
   * otherwise returns 0 */
  int digit, evenDigitSum = 0, oddDigitSum = 0;

  while (len != 0) {
    digit = n%10;
    if (digit % 2 == 0) evenDigitSum += digit;
    else oddDigitSum += digit;
    n /= 10;
    len--;
  }
  return (evenDigitSum == oddDigitSum);
}

int main(int argc, char *argv[]) {
  int n;

  scanf("%d", &n);
  int len = countDigits (n);
  if (isBalancedNumber (n, len)) printf("YES\n");
  else printf("NO\n");

  return 0;
}
