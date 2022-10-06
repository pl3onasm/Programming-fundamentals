/* file: prob3.c
   author: David De Potter
   description: IP Final 2015, problem 3, bit reversal of integers
*/

#include <stdio.h>
#include <stdlib.h>

int bitrev(int n) {
  int bitrev = 0;
  while (n>0) {
    bitrev = bitrev*2 + n%2;
    n >>= 1;
  }
  return bitrev;
}

int main() {
  int n;
  scanf ("%d", &n); /* you may assume that n >= 0 */
  printf("bitrev(%d)=%d\n", n, bitrev(n));
  return 0;
}