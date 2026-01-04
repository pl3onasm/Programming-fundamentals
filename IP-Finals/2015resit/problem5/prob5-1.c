/* file: prob5-1.c
   author: David De Potter
   version: 5.1, this version works with a void function, 
     so that the evaluations have to be done separately 
     when the base case is reached
   description: IP Final 2015 resit, problem 5, recursion
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Generates all possible expressions by placing '+' or '-'
// operators between the integers in array a of given length,
// evaluates them, and updates count of how many evaluate to n
void generateExprs(int length, int n, int a[], int ops[], 
                   int idx, int *count) {

    // base case: all operators have been set
  if (idx == length - 1){   
    int eval = a[0];  
    for (int i = 0; i < length - 1; ++i){
      if (ops[i]) eval += a[i + 1];
      else eval -= a[i + 1];
    }
    if (eval == n) ++*count;
    return; 
  }

    // recursive case: set next operator to '+' (1) or '-' (0)
  ops[idx] = 1; 
  generateExprs(length, n, a, ops, idx + 1, count);
  
  ops[idx] = 0; 
  generateExprs(length, n, a, ops, idx + 1, count);
}

//=================================================================
// Initiates the generation of expressions and counting
int plusmin(int length, int a[], int n) {
  int count = 0, ops[100];

  generateExprs(length, n, a, ops, 0, &count);

  return count;
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