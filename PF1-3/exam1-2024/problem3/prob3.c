/* file: prob3.c
   author: David De Potter
   description: PF 1/3rd term 2024, problem 3, 
                primal sum iterations
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// checks whether x is prime
int isPrime (int x) {
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2) {
    if (x % i == 0) return 0;
  }
  return 1;
}

//===================================================================
// returns the product between the number of distinct
// prime factors of n and the sum of those factors
int compProduct(int n) {
  int sum = 0, nFactors = 0;
  for (int i = 2; n > 1 && i * i <= n; i += i == 2 ? 1 : 2) {
    if (n % i == 0) {
      sum += i;
      ++nFactors;
      while (n % i == 0)
        n /= i;
    }
  }

  if (isPrime(n)) {
    ++nFactors;
    sum += n;
  }
  
  return sum * nFactors;
}

//===================================================================

int main() {
  int a, b;
  assert(scanf("%d %d", &a, &b) == 2);

  int maxIter = -1, maxNum = 0;

  for (int i = a; i <= b; i++) {
    int nIter, n = i;
    for (nIter = 0; n != 10 && n != 30 ; nIter++) {
      int m = compProduct(n);
      if (m == n) break;  // we have reached a prime number
      n = m;
    }

    if (nIter > maxIter) {
      maxIter = nIter;
      maxNum = i;
    }
  }

  printf("%d %d\n", maxNum, maxIter);

  return 0;
}