/* file: prob5-2.c
   author: David De Potter
   version: 5.2, this version works with an int function,
   so that the total sums are computed during the recurive calls
   and counted if they are equal to the target sum.
   description: IP Final 2015 resit, problem 5, recursion
*/

#include <stdio.h>
#include <stdlib.h>

int countExps(int length, int n, int a[], int idx, int sum) {
  // base case: check computed sum
  if (idx == length-1) return sum == n;
  // recursive case: add / subract next term
  return countExps(length, n, a, idx+1, sum + a[idx+1])
       + countExps(length, n, a, idx+1, sum - a[idx+1]);
}

int plusmin(int length, int a[], int n) {
  return countExps(length, n, a, 0, a[0]);
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