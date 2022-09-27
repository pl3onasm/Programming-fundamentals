/* file: goodprimes.c
  author: David De Potter
  description: IP mid2021, problem 3, good primes, alternative version
*/

#include <stdio.h>
#include <stdlib.h>

int isGoodPrime(int p) {
  int a, b;
  if ((p < 3) || (!isPrime(p))) {
    return 0;
  }
  a = (p == 3 ? 2 : p - 2);
  while (!isPrime(a)) {
    a -= 2;
  }
  b = p + 2;
  while (!isPrime(b)) {
    b += 2;
  }
  return (a*b < p*p);
}

int isPrime(int n) {
  if (n < 3) {
    return (n == 2);
  }
  if (n%2 == 0) {
    return 0;
  }
  int d = 3;
  while (d*d <= n) {
    if (n%d == 0) {
      return 0;
    }
    d = d + 2;
  }
  return 1;
}

int main(int argc, char *argv[]) {
  int a, b, cnt=0;
  scanf("%d %d", &a, &b);
  for (int n=a; n <= b; n++) {
    cnt += isGoodPrime(n);
  }
  printf("%d\n", cnt);
  return 0;
}