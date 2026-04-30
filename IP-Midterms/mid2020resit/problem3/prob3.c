/* file: prob3.c
  author: David De Potter
  description: IP mid2020 resit, problem 3, n-gap prime pairs
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

int main() {
  int a, b, n, count = 0;
  assert(scanf("%d %d %d", &a, &b, &n) == 3);

  for (int i = a; i <= b - n; ++i) 
    if (isPrime(i) && isPrime(i + n))
      ++count; 

  printf("%d\n", count);
  return 0;
}
