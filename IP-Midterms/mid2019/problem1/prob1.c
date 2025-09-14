/* file: prob1.c
* author: David De Potter
* description: IP mid2019, problem 1, decimal numbers
*/

#include <stdio.h>
#include <stdlib.h>

int power(int n, int exp) {
  // returns n^exp using binary exponentiation
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n; 
    exp /= 2;
  }
  return pow;
}

int countDigits(int n) {
  /* returns length of integer n */
  int count=0;
  while (n != 0) {
    count++; 
    n /= 10;
  }
  return count;
}

int main(int argc, char *argv[]) {
  int n, digit;

  (void)! scanf("%d", &n);
  printf("%d=", n);

  int len = countDigits(n);

  for (int exp = len-1; exp >= 0; exp--) {
    digit = (n / power(10,exp)) % 10;
    if (digit) {
      if (exp < len-1) printf(" + ");
      printf("%d*10^%d", digit, exp);
    } 
  }

  printf("\n");
  return 0;
}
