/* file: prob2.c
  author: David De Potter
  description: IP mid2021, problem 2, peculiar numbers
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //checks whether given number is prime
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int digitSum (int n) {
  int sum = 0;
  while (n) {
    sum += n % 10;
    n /= 10;
  }
  return sum; 
}

int digitProduct (int n) {
  int prod = 1;
  while (n) {
    prod *= n % 10;
    n /= 10;
  }
  return prod; 
}

int isPerfSquare (int n) {
  // returns 1 if n is a perfect square, 0 otherwise
  int i; 
  for (i=1; i*i < n; ++i);
  return (i*i == n); 
}

int main(int argc, char *argv[]) {
  int a, b, count=0;
  
  (void)! scanf("%d %d", &a, &b);
  for (int i = a; i<=b; ++i)
    count += isPrime(digitSum(i)) && isPerfSquare(digitProduct(i)); 

  printf("%d\n", count);
  return 0;
}