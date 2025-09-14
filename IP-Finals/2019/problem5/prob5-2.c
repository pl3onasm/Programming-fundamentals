/* 
  file: prob5-2.c
  author: David De Potter
  version: 5.2, using an int function and 
    local int variable to count
  description: IP final exam 2019, problem 5,
    increasing Fibonacci sums
*/

#include <stdio.h>
#include <stdlib.h>

void computeFibSeries (int n, int idx, int *len, int *fib) {
  /* Base case */
  if (fib[idx-1] >= n || idx > 47) {
    *len = idx-1;
    return;
  }
  /* Recursive case */
  fib[idx] = fib[idx-2] + fib[idx-1];
  computeFibSeries (n, idx+1, len, fib);
}

int checkFibSums (int target, int sum, int idx, int *fib) {
  int count;
  /* Base case */
  if (idx < 0) return target == sum;
  /* Recursive case */
  count = checkFibSums (target, sum + fib[idx], idx-1, fib);
  count += checkFibSums (target, sum, idx-1, fib);
  return count;
}

int main (int argc, char *argv[]) {
  int n, len = 0, fib[48] = {1, 2};

  (void)! scanf("%d", &n);

  computeFibSeries (n, 2, &len, fib);

  printf ("%d\n", checkFibSums (n, 0, len-1, fib));

  return 0;
}
