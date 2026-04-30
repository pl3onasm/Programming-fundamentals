/* file: prob3.c
   author: David De Potter
   description: IP Final 2015, problem 3, bit reversal of integers
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes the bit reversal of n
int bitrev(int n) {
  int rev = 0;
  while (n > 0) {
    rev = rev * 2 + (n & 1);
    n >>= 1;
  }
  return rev;
}

//=================================================================

int main() {
  int n;
  
  assert(scanf("%d", &n) == 1);  
  
  printf("bitrev(%d)=%d\n", n, bitrev(n));
  
  return 0;
}