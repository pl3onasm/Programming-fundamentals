/* file: prob4a.c
   author: David De Potter
   description: IP Final 2014, problem 4a, Iterative algorithms,
   factorial sum
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if n equals the sum of the factorials of its digits
int isFactorialSum(int n) {
  if (n < 0) return 0;
  if (n >= 10000000) return 0;

  int sum = 0, fact[10], x = n;
  fact[0] = 1;
  
  for (int i = 1; i < 10; i++)
      // precompute factorials for 1 up to 9
    fact[i] = fact[i - 1] * i;
    
  if (x == 0) sum = fact[0];
  else {
    while (x > 0 && sum <= n) {
      sum += fact[x % 10];
      x /= 10;
    }
  }
  
  return sum == n;
}

//=================================================================

int main() {
  int a; 

  assert(scanf("%d", &a) == 1);
  
  printf(isFactorialSum(a) ? "YES\n" : "NO\n");
  
  return 0;
}