/* 
  file: prob5-1.c
  author: David De Potter
  version: 5.1, using a void function and 
    an int pointer to count
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

void checkFibSums (int target, int sum, int idx, int *count, int *fib) {
  /* Base case */
  if (idx < 0) {
    if (target == sum) ++*count;
    return;
  }
  /* Recursive case */
  checkFibSums (target, sum + fib[idx], idx-1, count, fib);
  checkFibSums (target, sum, idx-1, count, fib);
}

int main (int argc, char *argv[]) {
  int n, len = 0, count = 0;
  int fib[48] = {1, 2};

  (void)! scanf("%d", &n);

  computeFibSeries (n, 2, &len, fib);

  checkFibSums (n, 0, len-1, &count, fib);
  printf ("%d\n", count);

  return 0;
}
