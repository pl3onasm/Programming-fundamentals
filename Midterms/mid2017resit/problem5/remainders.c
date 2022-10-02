/* file: remainders.c
* author: David De Potter
* description: problem 5, remainders, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

void swap(int *a, int *b) {
  int h;
  h = *a;
  *a = *b;
  *b = h;
}

int main(int argc, char *argv[]) {
  int rem1, rem2, rem3, mod1, mod2, mod3, i, g;

  scanf("%d %d", &rem1, &mod1);
  scanf("%d %d", &rem2, &mod2);
  scanf("%d %d", &rem3, &mod3);
  /* we want to get the maximum modulus, and perform
   * any swaps as needed */
  if (mod2 > mod1) {
    swap(&mod1, &mod2);
    swap(&rem1, &rem2);
  }
  if (mod3 > mod1) {
    swap(&mod1, &mod3);
    swap(&rem1, &rem3);
  }
  /* gets the smallest number that satisfies the equation
   * that contains the biggest modulus (divisor) */
  for (i = 0;; ++i) {
    if (i % mod1 == rem1) {
      g = i;
      break;
    }
  }
  /* now we can skip through the rest of the numbers using the
   * biggest modulus as the interval, starting from the first
   * number that satisfied the equation with said modulus */
  for (i = g;; i+= mod1) {
    if ((i % mod2 == rem2) && (i % mod3 == rem3))
      break;
  }
  printf("%d\n", i);
  return 0;
}
