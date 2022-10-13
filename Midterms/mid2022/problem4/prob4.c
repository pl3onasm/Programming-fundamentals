/* file: prob4.c
   author: David De Potter
   description: IP mid2022, problem 4, Cuban primes
   The trick is to just simplify the given expression, 
   using the fact that a^3 - b^3 = (a-b)(a^2 + ab + b^2), 
   in the following way: 
   p = (q+1)^3 - q^3 = (q+1-q)((q+1)^2 + q*(q+1) + q^2) 
   = 3*q^2 + 3*q + 1 = 3*q*(q+1) + 1
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int p; 
  scanf("%d", &p);
  for (int q = 2; q < p; ++q) {
    if (p == 3*q*(q+1)+1) {
      printf("YES\n");
      return 0;
    }
  }
  printf("NO\n");
  return 0;
}