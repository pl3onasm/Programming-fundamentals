/* file: prob4.c
   author: David De Potter
   description: IP Final 2017 Resit, problem 4,
	 repeated permutations
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes the greatest common divisor (GCD) of a and b
int GCD(int a, int b) {
  if (b == 0) return a;
  return GCD(b, a % b);
}

//=================================================================
// Computes the least common multiple (LCM) of a and b
int LCM(int a, int b) {
  return a / GCD(a, b) * b;
}

//=================================================================

int main() {
  int n, cycles[100], steps[100] = {0};
  assert(scanf("%d", &n) == 1);

  for (int i = 0; i < n; ++i) 
    assert(scanf("%d", cycles + i) == 1);

  for (int i = 0; i < n; ++i) {
    if (cycles[i] < 0) 
      continue;
    int j = i;
    while (cycles[j] >= 0) {
      int k = cycles[j];
      cycles[j] = -1;
      j = k;
      ++steps[i];
    }
  }

  int lcm = steps[0];
  for (int i = 1; i < n; ++i) {
    if (steps[i] == 0) 
      continue;
    lcm = LCM(lcm, steps[i]);
  }

  printf("%d\n", lcm);
  return 0;
}