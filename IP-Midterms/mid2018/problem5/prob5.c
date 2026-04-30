/* file: prob5.c
  author: David De Potter
  description: problem 5, Pythagorean triples, mid2018
  
  We apply some algebraic manipulation to avoid computing any 
  square roots. The goal is to express a, b, c in terms of two 
  integers x and y.

  We start from:        a^2 + b^2 = c^2

  and rewrite it as:    a^2 = c^2 - b^2 = (c - b)(c + b)

  Dividing by a(c + b) gives:

    a / (c + b) = (c - b) / a

  For a primitive triple, the quantities involved are "as reduced 
  as possible" (gcd(a,b,c)=1). In that situation we may represent 
  these two equal fractions by a ratio of two coprime integers 
  x/y with y > x:

    a / (c + b) = x / y
    (c - b) / a = x / y

  Equivalently:

    y/x = (c + b)/a = c/a + b/a
    x/y = (c - b)/a = c/a - b/a

  Adding the two equations yields:

    2*c/a = y/x + x/y = (y^2 + x^2) / (xy)

  Subtracting them yields:

    2*b/a = y/x - x/y = (y^2 - x^2) / (xy)

  Hence we obtain Euclid's parameterization:

    a = 2xy
    b = y^2 - x^2
    c = x^2 + y^2

  To ensure (a,b,c) is primitive, we need:
    gcd(x,y) = 1   
    x+y is odd (avoids both x,y odd and introducing a factor 2)

  We now just need to count all pairs (x,y) satisfying 
  these conditions such that a + b + c = n.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes the greatest common divisor of a and b
int GCD(int a, int b) {
  if (b == 0) return a;
  return GCD(b, a % b);
}

//=================================================================
// Checks if x and y are coprime
int areCoprime(int x, int y) {
  return GCD(x, y) == 1;
}

//=================================================================

int main() {
  int n, x, y, count = 0;

  assert(scanf("%d", &n) == 1);

  for (y = 2; 2 * y * (y + 1) <= n; ++y) {    
    for (x = 1; x < y; ++x) {
      int perim = 2 * y * (y + x);        // perimeter = a + b + c
      if (perim > n) break;
      if (perim == n && areCoprime(x, y) && ((x + y) % 2))
        ++count;
    }
  }

  printf("%d\n", count);
  return 0;
}

