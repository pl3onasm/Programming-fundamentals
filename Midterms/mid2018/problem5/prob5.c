/* file: prob5.c
* author: David De Potter
* description: problem 5, Pythagorean triples, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int GCD(int a, int b) {
  if (b == 0) return a;
  return GCD(b, a%b);
}

int noCommonDivisors (int x, int y, int z) {
  return (GCD(x, y) == 1 && GCD(y, z) == 1 && GCD(x, z) == 1);
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

