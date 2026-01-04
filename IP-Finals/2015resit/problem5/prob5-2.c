/* file: prob5-2.c
   author: David De Potter
   version: 5.2, this version works with an int function,
     so that the total sums are computed during the recursive 
     calls and counted if they are equal to the target sum.
   description: IP Final 2015 resit, problem 5, recursion
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Generates all possible expressions by placing '+' or '-'
// operators between the integers in array a of given length,
// evaluates them, and returns how many evaluate to n
int countExps(int length, int n, int a[], int idx, int sum) {

    // base case: all operators have been set,
    // check if sum equals target n
  if (idx == length - 1) 
    return sum == n;

    // recursive case: set next operator by either
    // adding or subtracting the next integer a[idx + 1]
  return countExps(length, n, a, idx + 1, sum + a[idx + 1])
       + countExps(length, n, a, idx + 1, sum - a[idx + 1]);
}

//=================================================================
// Initiates the generation of expressions and counting
int plusmin(int length, int a[], int n) {
  return countExps(length, n, a, 0, a[0]);
}

//=================================================================

int main() {
  int len, n, i, a[100];

  assert(scanf ("%d %d", &len, &n) == 2);

  for (i = 0; i < len; ++i) 
    assert(scanf("%d", &a[i]) == 1);
  
  printf("%d\n", plusmin(len, a, n));

  return 0;
}