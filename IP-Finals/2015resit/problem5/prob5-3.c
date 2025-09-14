/* file: prob5-3.c
   author: David De Potter
   version: 5.3, same as 5.2 but going in reverse through
   the array, so we can combine the index and length parameters
   description: IP Final 2015 resit, problem 5, recursion
*/

#include <stdio.h>
#include <stdlib.h>

int countExps(int idx, int goal, int a[], int sum) {
  // base case: check computed sum
  if (idx == 0) return sum + a[0] == goal;
  // recursive case: add / subract next term
  return countExps(idx-1, goal, a, sum + a[idx]) 
       + countExps(idx-1, goal, a, sum - a[idx]);
}

int plusmin(int length, int a[], int goal) {
  return countExps(length-1, goal, a, 0);
}

int main() {
  int len, n, i, a[100];
  (void)! scanf ("%d %d", &len, &n);
  for (i=0; i < len; i++) {
    (void)! scanf("%d", &a[i]);
  }
  printf("%d\n", plusmin(len, a, n));
  return 0;
}