/* 
  file: prob5-3.c
  author: David De Potter
  version: 5.3, yet another variation
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
  /* Base case */
  if (idx < 0) return target == sum;
  /* Recursive case */
  return checkFibSums (target, sum + fib[idx], idx-1, fib)
       + checkFibSums (target, sum, idx-1, fib);
}

int main (int argc, char *argv[]) {
  int n, len = 0, fib[48] = {1, 2};

  (void)! scanf("%d", &n);

  computeFibSeries (n, 2, &len, fib);

  printf ("%d\n", checkFibSums (n, 0, len-1, fib));

  return 0;
}
