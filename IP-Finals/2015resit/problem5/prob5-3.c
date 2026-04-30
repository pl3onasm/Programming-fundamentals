/* file: prob5-3.c
   author: David De Potter
   version: 5.3, same as 5.2 but going in reverse through
     the array, so we can combine the index and length parameters
   description: IP Final 2015 resit, problem 5, recursion
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Generates all possible expressions by placing '+' or '-'
// operators between the integers in array a of given length,
// evaluates them, and returns how many evaluate to n
int countExps(int idx, int goal, int a[], int sum) {

    // base case: all operators have been set,
    // check if sum equals goal
  if (idx == 0) 
    return sum + a[0] == goal;

    // recursive case: add / subtract next term
  return countExps(idx - 1, goal, a, sum + a[idx]) 
       + countExps(idx - 1, goal, a, sum - a[idx]);
}

//=================================================================
// Initiates the generation of expressions and counting
int plusmin(int length, int a[], int goal) {
  return countExps(length - 1, goal, a, 0);
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