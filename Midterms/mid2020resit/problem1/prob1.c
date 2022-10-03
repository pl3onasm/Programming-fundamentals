/* file: prob1.c
  author: David De Potter
  description: IP mid2020 resit, problem 1, Nine's complement
*/

#include <stdio.h>
#include <stdlib.h>

int power(int n, int exp) {
  /* returns n^exp */
  int m=1;
  while (exp != 0) {
    if (exp%2 == 0) {
      n *= n; exp /= 2;
    } else {
      m *= n; exp--;
    }
  }
  return m;
}

int countDigits(int n) {
  int count = 0;
  while (n>0) {
    count++; n /= 10;
  }
  return count;
}

int main(int argc, char *argv[]) {
  int n;
  scanf("%d",&n);
  int len = countDigits(n);
  for (int i=len-1; i>=0; --i) {
    printf("%d", 9 - n/power(10,i));
    n %= power(10,i);
  }
  printf("\n");

  return 0;
}