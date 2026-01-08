/* file: prob1.c
   author: David De Potter
   description: problem1, multiples. mid2015
   time complexity: O(log(min(a,b))) due to the GCD computation,
     which practically reduces to O(1) for the given constraints
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes the greatest common divisor of a and b
int GCD (int a, int b) {
  if (b == 0) return a;
  return GCD(b, a % b);
}

//=================================================================
// Computes the least common multiple of a and b
int LCM (int a, int b) {
  return (a / GCD(a, b)) * b;
}

//=================================================================

int main() {
  int a, b, n;

  assert(scanf("%d %d %d", &a, &b, &n) == 3);
  
  printf("%d\n", n / LCM(a, b));

  return 0;
}
 