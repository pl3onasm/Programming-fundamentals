/* file: prob4.c
   author: David De Potter
   description: problem 4, Smith numbers, mid2016
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if n is prime
int isPrime(int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================
// Returns the sum of the digits of n
int sumDigits (int n) {
  int sum = 0; 
  while (n > 0) {
    sum += n % 10; 
    n /= 10;
  }
  return sum;
}

//=================================================================
// Returns the sum of the digits in x's prime factorization
int sumFactorDigits(int x) {
  int sum = 0;

  for (int d = 2; d <= x / d; ++d) {
    while (x % d == 0) {
      sum += sumDigits(d);
      x /= d;
    }
  }

  if (x > 1)
    sum += sumDigits(x);

  return sum;
}

//=================================================================

int main() {
  int x;
  assert(scanf("%d", &x) == 1);

  if (x <= 1 || isPrime(x)) 
    printf("NO\n");
  else 
    printf(sumDigits(x) == sumFactorDigits(x) ? "YES\n" : "NO\n");
  
  return 0;
}
