/* file: prob3.c
   author: David De Potter
   description: PF 1/3rd resit 2026, problem 3, 
                Reverse multiple
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Reverses the decimal digits of a given integer.
// Leading zeros in the reversed representation are discarded;
// for example, reverse(120) returns 21.
int reverse(int n) {
  int rev = 0;
  while (n) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

//===================================================================

int main() {
  int n, a, b;
  int count = scanf("%d %d %d", &n, &a, &b);
  assert(count == 3);

  int revn = reverse(n);

  for (int k = a; k <= b; k++) {
    if (reverse(k * n) == k * revn) {
      printf("%d\n", k);
      return 0;
    }
  }

  printf("NONE\n");

  return 0;
}