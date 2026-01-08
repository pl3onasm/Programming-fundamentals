/* file: prob2.c
  author: David De Potter
  description: IP mid2020 resit, problem 2, unitary divisors
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes the greatest common divisor of a and b
int GCD (int a, int b) {
  if (b == 0) return a;
  return GCD(b, a % b);
}

//=================================================================
// Checks if a and b have no common divisors, 
// i.e. if they are coprime
int areComprime (int a, int b) {
  return GCD(a, b) == 1;
}

//=================================================================

int main() {
  int n, d; 
  
  assert(scanf("%d %d", &d, &n) == 2);
  if (n % d == 0 && areComprime(d, n / d)) 
    printf("YES\n");
  else 
    printf("NO\n");

  return 0;
}