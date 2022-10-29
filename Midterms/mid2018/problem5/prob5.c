/* file: prob5.c
  author: David De Potter
  description: problem 5, Pythagorean triples, mid2018
  The Pythagorean theorem works with perfect squares, so
  that the roots a, b, c will be integers.
  We need to apply some algebraic manipulation in order to
  find the triplets. We don't want to compute the roots to
  get a, b, c, instead we just assume having the roots x 
  and y, and we compute a and b from them. So we have:
      c = sqrt((x² + y²)²)
  <=> c² = (x² + y²)²
  <=> c² = x⁴ + 2x²y² + y⁴
  <=> c² = x⁴ - 2x²y² + y⁴ + 4x²y²
  <=> c² = (y² - x²)² + 4x²y²
  <=> c² = a² + b², where a = y² - x² and b = 2x²y²
  Now we just need to find all the pairs (x, y) such that
  a + b + c = n.
*/

#include <stdio.h>
#include <stdlib.h>

int GCD(int a, int b) {
  // returns the greatest common divisor of a and b
  if (b == 0) return a;
  return GCD(b, a%b);
}

int noCommonDivisors (int x, int y, int z) {
  // checks if x, y and z are coprime
  return (GCD(x, y) == 1 && GCD(y, z) == 1 && GCD(x, z) == 1);
}

int main(int argc, char *argv[]) {
  int n, a, b, c, x, y, count=0;
  scanf("%d", &n);

  for (x=1; x < n/3; ++x) {
    for (y=x+1; y < n-x; ++y) {
      /* express pythagorean relationship without
       * having to compute roots x and y first */
      a = y * y - x * x;  // since y > x, a is always positive
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

