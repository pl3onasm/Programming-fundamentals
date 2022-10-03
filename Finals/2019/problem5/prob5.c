/* file: prob5.c
* author: David De Potter
* version: 1.0
* (using a void function and an int pointer to count)
* description: IP final exam 2019, problem 5,
* increasing Fibonacci sums
*/

#include <stdio.h>
#include <stdlib.h>

int fib[47];

void computeFibSeries (int n, int idx, int *len) {
  /* Base case */
  if (fib[idx-1] >= n || idx > 47) {
    *len = idx-1;
    return;
  }
  /* Recursive case */
  fib[idx] = fib[idx-2] + fib[idx-1];
  computeFibSeries (n, idx+1, len);
}

void checkFibSums (int target, int sum, int idx, int *count) {
  /* Base case */
  if (idx < 0) {
    if (target == sum) (*count)++;
    return;
  }
  /* Recursive case */
  checkFibSums (target, sum + fib[idx], idx-1, count);
  checkFibSums (target, sum, idx-1, count);
}

int main (int argc, char *argv[]) {
  int n, len=0, count=0;

  scanf("%d", &n);

  fib[0] = 1;
  fib[1] = 2;
  computeFibSeries (n, 2, &len);

  checkFibSums (n, 0, len-1, &count);
  printf ("%d\n", count);

  return 0;
}
