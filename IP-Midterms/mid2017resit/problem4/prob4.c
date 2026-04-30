/* file: prob4.c
   author: David De Potter
   description: problem 4, encapsulating primes, resit mid2017
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
// Gets the encapsulated number by removing the first and last 
// digit of x
int getInnerNumber (int x) {
  int pow10 = 1;

    // find highest power of 10 below x
  while (x / pow10 >= 10)  
    pow10 *= 10;

  return (x % pow10) / 10;
}

//=================================================================

int main() {
  int n;
  assert(scanf ("%d", &n) == 1);

  if (!isPrime(n)) {
    printf("NO\n");
    return 0; 
  }
  
  printf(isPrime(getInnerNumber(n)) ? "YES\n" : "NO\n");
  
  return 0;
}
