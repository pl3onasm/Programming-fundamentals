/* file: prob2.c
   author: David De Potter
   description: PF 1/3rd term 2023, problem 2, right-truncable primes
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //checks whether x is prime
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2) {
    if (x % i == 0) return 0;
  }
  return 1;
}

int main(int argc, char *argv[]) {
  int n;

  (void)! scanf("%d", &n);

  if (n == 0) {       // special case for input 0
    printf("NO\n");
    return 0;
  }

  while (n) {         // check if all right-truncable numbers are prime
    if (isPrime(n)) 
      n /= 10;        // remove last digit
    else {
      printf("NO\n"); // at least one of the remainders is not prime
      return 0;
    }
  }
  printf("YES\n");
  return 0;
}