/* file: decimal.c
* author: David De Potter
* description: IP mid2019, problem 1, decimal numbers
*/

#include <stdio.h>
#include <stdlib.h>

int power(int num, int exp) {
  /* returns number^exponent */
  int m=1;
  while (exp!=0) {
    if (exp%2 == 0) {
      num *= num; exp <<= 1;
    } else {
      m *= num; exp--;
    }
  }
  return m;
}

int countDigits(int n) {
  /* returns length of integer n */
  int count=0;
  while (n != 0) {count++; n /= 10;}
  return count;
}

int main(int argc, char *argv[]) {
  int n, digit;

  scanf("%d", &n);
  printf("%d=", n);
  int len = countDigits(n);
  int exp = len-1;

  for (int i = 0; i < len; ++i) {
    digit = (n / power(10,exp)) % 10;
    if (i == 0) printf("%d*10^%d", digit, exp);
    else if (digit != 0) printf(" + %d*10^%d", digit, exp);
    exp--;
  }

  printf("\n");
  return 0;
}
