/* file: prob2.c
  author: David De Potter
  description: IP mid2021, problem 2, peculiar numbers
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Check if n is prime
int isPrime(int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================
// Calculates the sum of the digits of n
int digitSum (int n) {
  int sum = 0;
  while (n) {
    sum += n % 10;
    n /= 10;
  }
  return sum; 
}

//=================================================================
// Calculates the product of the digits of n
int digitProduct (int n) {
  if (n == 0) return 0;
  int prod = 1;
  while (n) {
    prod *= n % 10;
    n /= 10;
  }
  return prod; 
}

//=================================================================
// Returns 1 if n is a perfect square, 0 otherwise
int isPerfSquare (int n) {
  if (n <  0) return 0;
  if (n == 0) return 1;
  int i; 
  for (i = 1; i < n / i; ++i);
  return (i * i == n); 
}

//=================================================================

int main() {
  int a, b, count = 0;
  
  assert(scanf("%d %d", &a, &b) == 2);
  for (int i = a; i <= b; ++i)
    count += isPrime(digitSum(i)) && isPerfSquare(digitProduct(i)); 

  printf("%d\n", count);
  return 0;
}