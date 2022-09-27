/* file: primal.c
* author: David De Potter
* description: IP mid2019, problem 5, primal sums
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //checks whether given number is prime
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int isPrimalSum (int n) {
  /* returns 1 if a primal sum is found
   * for the integer n */
  int sum = 0;

  for (int i = 1; i < n; ++i) {
    if (isPrime (i)) sum = i;
    for (int j = i+1; j < n; ++j) {
      if (isPrime (j)) sum += j;
      if (sum == n) return 1;
      if (sum > n) break;
    }
  }
  return 0;
}

int main(int argc, char *argv[]) {
  int a, b, count = 0;

  scanf("%d %d", &a, &b);
  for (int n = a; n <= b; n++)
    if (isPrime(n) && isPrimalSum(n))
      count++;

  printf("%d\n", count);
  return 0;
}
