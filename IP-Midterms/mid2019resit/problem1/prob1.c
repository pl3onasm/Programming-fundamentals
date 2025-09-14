/* file: prob1-2.c
* author: David De Potter
* description: IP mid2019 resit, problem 1,
* binary representation
*/

#include <stdio.h>
#include <stdlib.h>

int binExp(int n){
  // returns highest exponent of 2 smaller than n
  int exp = 0;
  while (n > 1){
    n >>= 1; 
    ++exp;
  }
  return exp;
}

int main(int argc, char *argv[]) {
  int n;
  (void)! scanf("%d", &n);
  printf("%d=", n);
  int len = binExp(n);

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
