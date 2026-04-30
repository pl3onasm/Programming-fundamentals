/* file: prob3.c
   author: David De Potter
   description: IP mid2021 resit, problem 3, lesser emirps
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
// Reverses the digits of an integer n
int reverse(int n) {
  int rev = 0;
  while (n > 0) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

//=================================================================

int main() {
  int a, b, count=0; 
  assert(scanf("%d %d", &a, &b) == 2);
  
  for (int i = a; i <= b; ++i) {
    if (isPrime(i)) {
      int rev = reverse(i);
      if (rev > i && isPrime(rev)) 
        ++count;
    } 
  }

  printf("%d\n", count); 

  return 0;
}