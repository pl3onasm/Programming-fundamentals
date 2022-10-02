/* file: primegaps.c
  author: David De Potter
  description: IP mid2020, problem 3, prime gaps
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

int main(int argc, char *argv[]) {
  int n, p, q;
  scanf("%d", &n);
  p = 2; q = 3;
  while (q-p < n) {
    p = q; 
    do ++q; 
    while (!isPrime(q));
  }
  printf("%d-%d=%d\n",p,q,q-p);
  return 0;
}