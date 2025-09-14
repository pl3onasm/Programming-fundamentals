/* file: prob4b.c
   author: David De Potter
   description: IP Final 2014, problem 4b, Iterative algorithms,
   Goldbach conjecture
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  // returns 1 if x is prime, 0 otherwise
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2) 
    if (x % i == 0) return 0;
  return 1;
}

int main(int argc, char *argv[]) {
  int n, s;
  for (n = 3; ; n+=2) 
    if (! isPrime(n)) {
      for (s=1; 2*s*s < n; ++s){
        if (isPrime(n - 2*s*s)) break;
      }
      if (2*s*s >= n) break;
    }
  printf("%d\n", n);
  return 0;
}