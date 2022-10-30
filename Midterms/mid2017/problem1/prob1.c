/* file: prob1.c
* author: David De Potter
* description: problem 1, amicable pairs, mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int sumDivisors (int n) {
  // returns the sum of n's proper divisors
  int sum = 1;
  for (int d = 2; d * d <= n; ++d) {
    if (n % d == 0) {
      if (d * d != n) sum += d + n / d;
      else sum += d; //count square root only once
    }
  }
  return sum;
}

int main(int argc, char *argv[]) {
  int a, b;
  scanf("%d %d", &a, &b);
  if (sumDivisors(a) == b && a == sumDivisors(b))
    printf("YES\n");
  else printf("NO\n");
  return 0;
}
