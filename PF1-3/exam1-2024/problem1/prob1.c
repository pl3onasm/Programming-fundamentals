/* file: prob1.c
   author: David De Potter
   description: PF 1/3rd term 2024, problem 1, powerful
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// computes the power of n to the exp 
int power(int n, int exp) {
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n;
    exp /= 2;
  }
  return pow;
}

//===================================================================

int main() {
  int n, sum = 0, exp = 0;
  assert(scanf("%d", &n) == 1);

  if (n == 0) {
    printf("1\n");
    return 0;
  }

  while (n) {
    sum += power(n % 10, exp++);
    n /= 10;
  }

  printf("%d\n", sum);

  return 0;
}