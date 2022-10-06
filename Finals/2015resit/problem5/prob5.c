/* file: prob5.c
   author: David De Potter
   description: IP Final 2015 resit, problem 5, recursion
*/

#include <stdio.h>
#include <stdlib.h>

void generateExpressions(int length, int n, int a[], 
  int ops[], int index, int *count) {
  // base case: all operators have been set
  if (index == length-1){   
    int eval = a[0];  
    for (int i = 0; i < length-1; ++i){
      if (ops[i]) eval += a[i+1];
      else eval -= a[i+1];
    }
    if (eval == n) ++(*count);
    return; 
  }
  // recursive case: set next operator
  ops[index] = 1; // +
  generateExpressions(length, n, a, ops, index+1, count);
  ops[index] = 0; // -
  generateExpressions(length, n, a, ops, index+1, count);
}

int plusmin(int length, int a[], int n) {
  int count = 0, ops[100];
  generateExpressions(length, n, a, ops, 0, &count);
  return count;
}

int main() {
  int len, n, i, a[100];
  scanf ("%d %d", &len, &n);
  for (i=0; i < len; i++) {
    scanf("%d", &a[i]);
  }
  printf("%d\n", plusmin(len, a, n));
  return 0;
}