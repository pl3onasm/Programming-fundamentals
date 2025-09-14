/* file: prob1.c
   author: David De Potter
   description: extra, problem 1, sum of multiples

   Explanation:
    The sum of all natural numbers from 1 to n is given by the
    formula n*(n+1)/2.

    Let's take for example a = 5 and b = 7.
    Observe that the sum of all multiples of 5 up to n is
    5+10+15+...+5*(n/5) = 5*(1+2+3+...+n/5) = 5*(n/5)*(n/5+1)/2
    Similarly, the sum of all multiples of 7 up to n is
    7*(n/7)*(n/7+1)/2
    
    However, if we add these two sums, we will have counted
    the numbers divisible by both 5 and 7 twice. We can correct 
    this by subtracting the sum of the multiples of the least
    common multiple of 5 and 7, which is 35. This sum is given
    by 35*(n/35)*(n/35+1)/2

    In general, the sum of all multiples of a and b up to n is
    a*(n/a)*(n/a+1)/2 + b*(n/b)*(n/b+1)/2 - lcm*(n/lcm)*(n/lcm+1)/2
    where lcm is the least common multiple of a and b.

    The practice of correcting for double counting when computing
    the size of the union of two sets is called the inclusion-
    exclusion principle. It can be formulated as follows:
    |A ⋃ B| = |A| + |B| - |A ⋂ B|
    where |A| denotes the cardinality of A, i.e. the number of
    elements in A. 
*/

#include <stdio.h>
#include <stdlib.h>
typedef unsigned long long int llu;

llu GCD (llu a, llu b) {
  // returns the greatest common divisor of a and b
  if (b == 0) return a;
  return GCD(b, a % b);
}

llu LCM (llu a, llu b) {
  // returns the least common multiple of a and b
  return a / GCD(a, b) * b;
}

llu addInts (llu n) {
  // returns the sum of all integers from 1 to n
  return n * (n + 1) / 2;
}
  
int main() {
  llu a, b, n;

  (void)! scanf("%llu %llu %llu", &a, &b, &n);

  --n;  // we want the sum of all multiples 
        // of a and b below n, not including n

  llu lcm = LCM(a, b);

  printf("%llu\n", a * addInts(n / a) + b * addInts(n / b)
                   - lcm * addInts(n / lcm));

  return 0;
}