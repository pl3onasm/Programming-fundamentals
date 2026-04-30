/* file: prob1.c
   author: David De Potter
   description: IP mid2019, problem 1, decimal numbers
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes n raised to the power exp using binary exponentiation
int power(int n, int exp) {
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n; 
    exp /= 2;
  }
  return pow;
}

//=================================================================
// Counts the number of digits in integer n
int countDigits (int n) {
  int count = 0;
  do {
    ++count;
    n /= 10;
  } while (n);
  return count;
}

//=================================================================

int main() {
  int n, digit;

  assert(scanf("%d", &n) == 1);
  printf("%d=", n);

  int len = countDigits(n);

  for (int exp = len - 1; exp >= 0; --exp) {
    digit = (n / power(10, exp)) % 10;
    if (digit) {
      if (exp < len - 1) printf(" + ");
      printf("%d*10^%d", digit, exp);
    } 
  }

  printf("\n");
  return 0;
}
