/* file: prob2.c
   author: David De Potter
   description: PF 1/3rd term 2023, problem 2, right-truncable primes
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks whether x is prime
int isPrime (int x) {
  if (x == 2) return 1;
  if (x % 2 == 0 || x < 2) return 0;
  for (int i = 3; i <= x / i; i += 2) 
    if (x % i == 0) return 0;
  return 1;
}

//=================================================================

int main(int argc, char *argv[]) {
  int n;

  assert(scanf("%d", &n) == 1);

  if (n < 2) {
    printf("NO\n"); 
    return 0; 
  }

  while (n) {
    if (!isPrime(n)) { printf("NO\n"); return 0; }
    n /= 10;
  }

  printf("YES\n");
  return 0;
}