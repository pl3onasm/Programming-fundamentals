/* file: prob4.c
* author: David De Potter
* description: problem 4, primal primes, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2) 
    if (x % i == 0) return 0;
  return 1;
}

int main(int argc, char *argv[]) {
  int n, index=0, x, primalPrimes=0;

  scanf ("%d", &n);
  for (x=1; ; ++x) {
    if (isPrime(x)) {
      ++index;
      if (isPrime(index)) {
        ++primalPrimes;
        if (primalPrimes == n) break;
      }
    }
  }
  printf("%d\n", x);
  return 0;
}
