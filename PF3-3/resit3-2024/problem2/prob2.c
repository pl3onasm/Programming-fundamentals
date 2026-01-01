/* 
  file: prob2.c
  author: David De Potter
  description: 3-3rd resit exam 2024, problem 2,
    special numbers
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Returns 1 iff n can be written as p*q where p and q are distinct 
// primes. Returns 0 otherwise.
// Precondition: n >= 1
int isProdOfTwoDistPrimes(int n) {
  int count = 0;
    // check number of prime factors up to sqrt(n)
  for (int i = 2; i <= n / i; i += (i == 2) ? 1 : 2) {
    while (n % i == 0) {
      n /= i;     
      if (++count > 1) 
          // If we divide by any prime more than once 
          // (square factor), or we find more than one  
          // prime factor in total, we can exit early
        return 0;
    }
  }
  return count == 1 && n > 1; 
}

//===================================================================

int main(){
  int m, count = 0, a = 0, b = 0, c = 0;

  assert(scanf("%d", &m) == 1);

   // We maintain a rolling window of size 3 to efficiently
   // check for triplets.
   // At iteration n, (c,b,a) corresponds to (n-2, n-1, n),
   // so if (a && b && c) then x = n-1 is special.
  for (int n = 3; n < m + 2; ++n) {
    c = b;
    b = a;
    a = isProdOfTwoDistPrimes(n);

    if (a && b && c) 
        // b is special
      ++count;
  } 

  printf("%d\n", count);
  return 0;
}

