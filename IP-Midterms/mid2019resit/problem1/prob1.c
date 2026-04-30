/* file: prob1-2.c
   author: David De Potter
   description: IP mid2019 resit, problem 1,
   binary representation
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Returns highest exponent of 2 such that 2^exp ≤ n
int binExp(int n){
  int exp = 0;
  while (n > 1){
    n >>= 1; 
    ++exp;
  }
  return exp;
}

//=================================================================

int main() {
  int n;
  assert(scanf("%d", &n) == 1);
  printf("%d=", n);
  int len = binExp(n);

  for (int i = len; i >= 0; --i) {
    if (i < len) printf(" + ");
    int pow2 = 1 << i;
    if (n >= pow2) {
      printf("1*2^%d", i);
      n -= pow2;
    } else printf("0*2^%d", i);
  }

  printf("\n");
  return 0;
}
