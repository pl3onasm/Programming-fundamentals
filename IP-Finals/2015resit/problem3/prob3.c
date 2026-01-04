/* file: prob3.c
   author: David De Potter
   description: IP Final 2015 resit, problem 3, counting emirps
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
// Reverses the digits of n
int reverse(int n) {
  int rev = 0;
  while (n > 0) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

//=================================================================
// Prints all emirps in the interval [a,b]
void printEmirps(int a, int b) {
  for (int i = a; i <= b; ++i) {
    int rev = reverse(i);
    if (isPrime(i) && isPrime(rev) && i != rev)
      printf("%d\n", i); 
  }
}

//=================================================================

int main() {
  int a, b; 

  assert(scanf("%d %d", &a, &b) == 2);

  printEmirps(a,b); 

  return 0; 
}
  