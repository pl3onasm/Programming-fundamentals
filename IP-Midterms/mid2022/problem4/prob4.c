/* file: prob4.c
   author: David De Potter
   description: IP mid2022, problem 4, Cuban primes
   The trick is to just simplify the given expression, 
   using the fact that a³ - b³ = (a-b)(a² + ab + b²), 
   in the following way: 
   p = (q+1)³ - q³ = (q+1-q)((q+1)² + q*(q+1) + q²) 
   = 3*q² + 3*q + 1 = 3*q*(q+1) + 1
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int p; 
  (void)! scanf("%d", &p);
  for (int q = 2; q < p; ++q) {
    if (p == 3*q*(q+1)+1) {
      printf("YES\n");
      return 0;
    }
  }
  printf("NO\n");
  return 0;
}