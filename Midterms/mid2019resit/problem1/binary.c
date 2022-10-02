/* file: binary.c
* author: David De Potter
* description: IP mid2019 resit, problem 1,
* binary representation
*/

#include <stdio.h>
#include <stdlib.h>

int getHighestExponent (int n) {
  int exp = 0;
  while (n > 0) {
    n /= 2; exp++;
  }
  return exp-1;
}

int main(int argc, char *argv[]) {
  int n, bit;

  scanf("%d", &n);
  printf("%d=", n);

  int len = getHighestExponent(n);

  for (int i = len; i >= 0; --i) {
    int diff = n - 1<<i;
    bit = diff >= 0 ? 1 : 0;
    n = bit ? diff : n;
    if (i == len) printf("%d*2^%d", bit, i);
    else printf(" + %d*2^%d", bit, i);
  }

  printf("\n");
  return 0;
}
