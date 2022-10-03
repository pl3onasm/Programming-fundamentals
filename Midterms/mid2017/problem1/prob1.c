/* file: prob1.c
* author: David De Potter
* description: problem 1, amicable pairs, mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int sumDivisors (int n) {
  int sum = 1;
  //sum starts at 1, as 1 is a proper divisor for all n
  for(int d=2; 2*d <= n; d++) 
    if (n%d == 0) sum += d;
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
