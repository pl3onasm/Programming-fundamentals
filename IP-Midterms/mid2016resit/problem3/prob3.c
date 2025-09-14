/* file: prob3.c
* author: David De Potter
* description: problem 3, mother of all primes, resit mid2016
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

int k_descendants (int p) {
  /* Determines number of k-descendants for a given
   * prime p. As each prime is its own 1-descendant,
   * desc=1 is the default return value
   */
  int desc = 1, n;

  for (int k=2; k <= 6; ++k) {
    //it is given that 1 <= p <= 1000000, so the
    //number of k-descendants will not exceed 6
    n = p*k + k-1;
    if (isPrime(n)) desc++;
    else break;
  }
  
  return desc;
}

int main(int argc, char *argv[]) {
  int a, b, p, k, n = 0, max = 0;

  (void)! scanf ("%d %d", &a, &b);

  for (p = a; p <= b; ++p) {
    if (isPrime(p)) {
      k = k_descendants(p);
      if (k > max) {
        //strictly greater than, because the smallest
        //solution needs to be printed in case of ties
        max = k;
        n = p;
      }
    }
  }

  printf (max ? "%d %d\n" : "NONE\n", n, max);
  return 0;
}
