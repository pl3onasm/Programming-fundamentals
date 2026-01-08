/* file: prob1.c
  author: David De Potter
  description: IP mid2020 resit, problem 1, Nine's complement
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
// Counts the number of digits in n
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
  int n;
  assert(scanf("%d",&n) == 1);

  if (n == 0) {
    printf("9\n");
    return 0;
  }
  
  int len = countDigits(n);
  
  for (int i = len - 1; i >= 0; --i) {
    int p = power(10, i);
    int digit = (n / p) % 10;
    printf("%d", 9 - digit);
  }

  printf("\n");

  return 0;
}

