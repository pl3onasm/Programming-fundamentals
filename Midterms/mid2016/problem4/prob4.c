/* file: prob4.c
* author: David De Potter
* description: problem 4, Smith numbers, mid2016
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //determines if x is prime
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int sumDigits (int n) {
  //returns the sum of n's digits
  int sum = 0; 
  while (n > 0) {
    sum += n%10; n /= 10;
  }
  return sum;
}

int sumFactorDigits(int x) {
  /* returns the sum of the digits
   * in x's prime factorization */
  int d=2, sum=0;
  while (x != 1) {  
    while (x % d == 0) {
      x /= d;
      sum += sumDigits(d);
    }
    d += 1;
  }
  return sum;
}

int main(int argc, char *argv[]) {
  int x;
  scanf("%d", &x);
  if (isPrime(x)) printf("NO\n");
    //smith number has to be a composite
  else {
    if (sumDigits(x) == sumFactorDigits(x)) printf("YES\n");
    else printf("NO\n");
  }
  return 0;
}
