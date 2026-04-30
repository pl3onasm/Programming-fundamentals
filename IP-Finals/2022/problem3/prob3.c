/* file: prob3.c
   author: David De Potter
   description: IP Final 2022, problem 3, Goldbach
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if n is prime
int isPrime (int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================

int main(){
  int n, count = 0; 
  assert(scanf("%d", &n) == 1);

    // n is even, so only odd a are relevant
  for (int a = 3; a < n / 2; a += 2) 
    if (isPrime(a) && isPrime(n - a)) 
      ++count; 
    
  printf("%d\n", count); 
  return 0; 
}