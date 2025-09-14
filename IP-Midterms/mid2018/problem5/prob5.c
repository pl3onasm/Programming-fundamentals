/* file: prob5.c
  author: David De Potter
  description: problem 5, Pythagorean triples, mid2018
  
  We need to apply some algebraic manipulation in order to
  easily find the triplets. We don't want to compute any roots 
  to get a, b, c, instead we try to find a, b, c in terms of
  two integers x and y. 

  We know that a² + b² = c², so we can rewrite this as:
  a² = c² - b² = (c - b)(c + b), so that
  a / (c + b) = (c - b) / a. We can represent these fractions
  as a ratio of two integers x and y: x/y, where y > x and both 
  have to be coprime, since a, b, c need to be coprime.
  
  This yields the following system of equations:
  y/x = c/a + b/a
  x/y = c/a - b/a

  Adding the two equations yields:
  2*c/a = y/x + x/y = (y² + x²) / xy
  Subtraction yields:
  2*b/a = y/x - x/y = (y² - x²) / xy

  Hence, c = (y² + x²), b = (y² - x²) and a = 2xy.
  Now we just need to find all the coprime pairs (x, y) such 
  that a + b + c = n.
*/

#include <stdio.h>
#include <stdlib.h>

int GCD(int a, int b) {
  // returns the greatest common divisor of a and b
  if (b == 0) return a;
  return GCD(b, a % b);
}

int noCommonDivisors (int x, int y) {
  // checks if x, y are coprime
  return GCD(x, y) == 1;
}

int main(int argc, char *argv[]) {
  int n, a, b, c, x, y, count = 0;
  (void)! scanf("%d", &n);

  for (x = 1; x < n/3; ++x) {
    for (y = x + 1; y < n - x; ++y) {
      a = 2*x*y;
      b = y*y - x*x;    // note that b is always positive
      c = x*x + y*y;
      if ((a + b + c == n) && noCommonDivisors(x, y))
        count++;
      if (c > n) break; // jumps to the next x
    }
  }

  printf("%d\n", count);
  return 0;
}

