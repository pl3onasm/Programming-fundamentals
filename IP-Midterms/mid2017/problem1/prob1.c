/* file: prob1.c
   author: David De Potter
   description: problem 1, amicable pairs, mid2017
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Returns the sum of n's proper divisors
int sumDivisors (int n) {
  if (n == 1) return 0;

  int sum = 1;
  
  for (int d = 2; d <= n / d; ++d) {
    if (n % d == 0) {
      int q = n / d;
      if (q != d)
        sum += d + q;
      else
        sum += d;     // count square root only once
    }
  }
  return sum;
}

//=================================================================

int main() {
  int a, b;

  assert(scanf("%d %d", &a, &b) == 2);

  if (sumDivisors(a) == b && a == sumDivisors(b))
    printf("YES\n");
  else 
    printf("NO\n");

  return 0;
}
