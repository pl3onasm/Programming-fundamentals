/* file: prob1-2.c
* author: David De Potter
* description: IP mid2019 resit, problem 1,
* binary representation
*/

#include <stdio.h>
#include <stdlib.h>

int getHighestExponent (int n) {
  int exp = 0;
  while (n > 0) {
    n >>= 1; exp++;
  }
  return exp-1;
}

int main(int argc, char *argv[]) {
  int n;
  scanf("%d", &n);
  printf("%d=", n);
  int len = getHighestExponent(n);

  for (int i=len; i>=0; i--) {
    if (i<len) printf(" + ");
    if (n >= 1<<i) {
      printf("1*2^%d", i);
      n -= 1<<i;
    } else printf("0*2^%d", i);
  }

  printf("\n");
  return 0;
}
