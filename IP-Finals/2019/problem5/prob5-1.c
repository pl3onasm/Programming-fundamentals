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
#include <assert.h>

//=================================================================
// Computes the Fibonacci series up to n using recursion. 
// The Fibonacci numbers are stored in fib[], and the length is
// returned via the len pointer.
void computeFibSeries (int n, int idx, int *len, int *fib) {

    // Base case: we have reached or exceeded n
  if (fib[idx - 1] >= n || idx > 47) {
    *len = idx - 1;
    return;
  }
  
    // Recursive case: compute next Fibonacci number
  fib[idx] = fib[idx - 2] + fib[idx - 1];
  computeFibSeries (n, idx + 1, len, fib);
}

//=================================================================
// Checks all subsets of Fibonacci numbers to count how many
// sum up to the target value.
void checkFibSums (int target, int sum, int idx, int *count, 
                   int *fib) {

    // Base case: no more Fibonacci numbers to consider
  if (idx < 0) {
    if (target == sum) ++*count;
    return;
  }
  
    // Prune branches that exceed the target sum to avoid
    // unnecessary computations
  if (sum > target)
    return;
  
    // Recursive case: include or exclude the current 
    // Fibonacci number
  checkFibSums (target, sum + fib[idx], idx - 1, count, fib);
  checkFibSums (target, sum, idx - 1, count, fib);
}

//=================================================================

int main () {
  int n, len = 0, count = 0;
  int fib[48] = {1, 2};

  assert(scanf("%d", &n) == 1);

  computeFibSeries (n, 2, &len, fib);

  checkFibSums (n, 0, len - 1, &count, fib);
  printf ("%d\n", count);

  return 0;
}
