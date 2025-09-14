/* file: prob2.c
  author: David De Potter
  description: IP mid2020 resit, problem 2, unitary divisors
*/

#include <stdio.h>
#include <stdlib.h>

int GCD (int a, int b) {
  // returns the greatest common divisor of a and b
  if (b == 0) return a;
  return GCD(b, a % b);
}

int haveNoCommonDivs (int a, int b) {
  // checks if a and b have no common divisors, i.e. if they're coprime
  return GCD(a, b) == 1;
}

int main(int argc, char *argv[]) {
  int n, d; 
  
  (void)! scanf("%d %d", &d, &n);
  if (n%d == 0 && haveNoCommonDivs(d, n/d)) printf("YES\n");
  else printf("NO\n");

  return 0;
}