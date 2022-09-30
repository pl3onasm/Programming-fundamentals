/* file: pythagorean.c
* author: David De Potter
* description: problem 2, Pythagorean triangles, mid2013
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int area, x;
  scanf("%d", &area);
  x = area * 2;
  /* x is the product a*b, so we need to check all
  * divisors (candidates for integers a and b) of x.
  * As a <= b, we only need to check up until the root of x */
  for (int i = 1; i * i <= x; ++i) {
    if (x % i == 0) {
      int a = i;      //a should be smallest divisor
      int b = x / a;  //the other divisor, so that a*b = x
      int square = a * a + b * b;
      int c = a;      //start with value a, as c > a
      do
        c++;
      while (c*c < square);
      if (square == c*c)
        printf("%d %d %d\n", a, b, c);
      }
    }
  return 0;
}
