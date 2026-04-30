/* file: prob3.c
  author: David De Potter
  description: IP mid2021, problem 3, good primes
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if an integer n is prime
int isPrime (int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================
// Gets the previous prime neighbour of p or p itself if p is prime
int getPrevPrime (int p) {
  if (p == 2) return p;
  if (p % 2 == 0) --p;
  while (! isPrime(p)) p -= 2; 
  return p;
}

//=================================================================
// Gets the next prime neighbour of p or p itself if p is prime
int getNextPrime (int p) {
  if (p == 2) return p;
  if (p % 2 == 0) ++p;
  while (! isPrime(p)) p += 2; 
  return p;
}

//=================================================================

int main() {
  int a, b, count = 0;
  
  assert(scanf("%d %d", &a, &b) == 2);

  int smallest = getPrevPrime(a - 1);
  int middle = getNextPrime(a);
  
  while (1) {
    int largest = getNextPrime(middle + 1);
    if (middle * middle > smallest * largest)
      ++count;
    smallest = middle;
    middle = largest;
    if (middle > b) break; 
  }

  printf("%d\n", count);
  return 0;
}