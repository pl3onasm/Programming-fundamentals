/* file: fibonacci.c
* author: David De Potter
* version: 2.0
* (using an int function and local int variable to count)
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

int checkFibSums (int target, int sum, int idx) {
  int count;
  /* Base case */
  if (idx < 0) {
    return (target == sum);
  }
  /* Recursive case */
  count = checkFibSums (target, sum + fib[idx], idx-1);
  count += checkFibSums (target, sum, idx-1);
  return count;
}

int main (int argc, char *argv[]) {
  int n, len=0;

  scanf("%d", &n);

  fib[0] = 1;
  fib[1] = 2;
  computeFibSeries (n, 2, &len);

  printf ("%d\n", checkFibSums (n, 0, len-1));

  return 0;
}
