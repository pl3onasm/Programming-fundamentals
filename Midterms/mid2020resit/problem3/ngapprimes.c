/* file: ngapprimes.c
  author: David De Potter
  description: IP mid2020 resit, problem 3, n-gap prime pairs
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //checks whether a given number is prime
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int main(int argc, char *argv[]) {
  int a, b, n, count = 0;
  scanf("%d %d %d", &a, &b, &n);

  for (int i=a; i<=b-n; ++i) {
    if (isPrime(i) && isPrime(i+n))
      count++; 
  }

  printf("%d\n", count);
  return 0;
}
