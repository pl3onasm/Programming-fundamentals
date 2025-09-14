/* file: prob1.c
  author: David De Potter
  description: IP mid2020 resit, problem 1, Nine's complement
*/

#include <stdio.h>
#include <stdlib.h>

int power(int n, int exp) {
  // returns n^exp using binary exponentiation
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n; 
    exp /= 2;
  }
  return pow;
}

int countDigits(int n) {
  int count = 0;
  while (n > 0) {
    count++; 
    n /= 10;
  }
  return count;
}

int main(int argc, char *argv[]) {
  int n;
  (void)! scanf("%d",&n);
  int len = countDigits(n);
  for (int i= len-1; i >= 0; --i) {
    printf("%d", 9 - n/power(10,i));
    n %= power(10,i);
  }
  printf("\n");

  return 0;
}

