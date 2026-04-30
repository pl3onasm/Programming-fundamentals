/* file: prob5.c
   author: David De Potter
   description: problem 5, modular Fermat, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes n^exp mod m using modular exponentiation
int modExp (int n, int exp, int m) {
  int pow = 1; n %= m;
  while (exp) {
    if (exp & 1) pow = (pow * n) % m;
    if (exp > 1) n = (n * n) % m;
    exp /= 2;
  }
  return pow;
}

//=================================================================
// Precomputes x^n mod n for x = 1..n-1
void precomputeModExp(int n, int me[]) {
  for (int x = 1; x < n; ++x) 
    me[x] = modExp(x, n, n);
}

//=================================================================

int main() {
  int n, count = 0, me[5001];

  assert(scanf ("%d", &n) == 1);

  precomputeModExp(n, me);
  
  for (int a = 1; a <= n - 2; ++a) {
      // c = n - a - b must satisfy c > b  
      // <=>  2*b < n - a
    int bMax = (n - a - 1) / 2;
    for (int b = a + 1; b <= bMax; ++b){ 
      int c = n - a - b; 
      if ((me[a] + me[b]) % n == me[c])
        ++count;
    }
  }
    
  printf("%d\n", count);
  return 0;
}
