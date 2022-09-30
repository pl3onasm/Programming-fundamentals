/* file: fib2.c
* author: David De Potter
* version: 2.0
* description: problem 4,
* Fibonacci’s bunnies again, mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  long fibmem[50];
  int i, runlength, m = 5;
  scanf("%d", &runlength);

  /* In this version we use the following equation for the number
   * of rabbit pairs in a generation:
   * R(n,m) = R(n-1) + R(n-2) - R(n-(m+1))
   * where run for n years, and rabbits die after m years
   * If we use a list, then we have a problem for n==m, because
   * the equation would need the value at position -1
   * So we need to provide this value ourselves.
   */

  for (i=0; i <= runlength; ++i) {
    if (i < 2)
      //normal Fibonacci initialization
      fibmem[i] = 1;
    else if ((i < m) || (m == 0))
      //normal Fibonacci computation, Fn = Fn−1 + Fn−2
      fibmem[i] = fibmem[i - 1] + fibmem[i - 2];
    else if (i == m)
      //i-(m+1) < 0, so we need to provide the missing value
      fibmem[i] = fibmem[i - 1] + fibmem[i - 2] - 1;
    else
      //now i-(m+1) >= 0, so we can get the value from the sequence
      fibmem[i] = fibmem[i - 1] + fibmem[i - 2] - fibmem[i - m - 1];
  }
  printf("%ld\n", fibmem[runlength]);
  return 0;
}
