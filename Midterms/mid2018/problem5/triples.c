/* file: triples.c
* author: David De Potter
* description: problem 5, Pythagorean triples, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int noCommonDivisors (int x, int y, int z) {
  //checks if the given arguments have no common divisors
  if ((x % 2 == 0) && (y % 2 == 0) && (z % 2 == 0))
    return 0;
  for (int d = 3; d <= z; d += 2) {
    /* we know z is the largest of the three given arguments,
    * so we only need to look for common divisors for d <= z */
    if ((x % d == 0) && (y % d == 0) && (z % d == 0))
      return 0;
  }
  return 1;
}

int main(int argc, char *argv[]) {
  int n, a, b, x, c=0, y, count=0;
  scanf("%d", &n);

  for (x=1; x < n/3; ++x) {
    for (y=x+1; y < n-x; ++y) {
      /* express pythagorean relationship without
       * having to compute roots x and y first */
      a = y * y - x * x;
      b = 2 * x * y;
      c = x * x + y * y;
      if ((a + b + c == n) && (noCommonDivisors(a, b, c)))
        count++;
      if (c > n) break; //jumps to the next x
    }
  }

  printf("%d\n", count);
  return 0;
}
