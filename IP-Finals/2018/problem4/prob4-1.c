/* file: prob4-1.c
   author: David De Potter
   version: 4.1, the naive split is in O(n³),
      the other split is in O(n²)
   description: IP Final 2018, problem 4, split3
*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAX(a,b) ((a) > (b) ? (a) : (b))

void *safeMalloc (int n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

void naiveSplit(int *arr, int size, int *min){
  /* naive way to compute the separate sums, in which
     the same sums are computed over and over again */
  int a = 0, b, c; 
  for (int i = 0; i < size-2; ++i){
    a += arr[i]; b = 0; 
    for (int j = i+1; j < size-1; ++j){
      b += arr[j]; c = 0;
      for (int k = j+1; k < size; ++k){
        c += arr[k];
      }
      int max = MAX(a, MAX(b, c));
      if (max < *min) *min = max;
    }
  }
}

void split(int *arr, int size, int *min){
  /* precomputes sums over the subarrays in order
     to avoid continually recomputing partial sums */ 
  int a, b, c;
  for (int i = 1; i < size; ++i) arr[i] += arr[i-1];
  int totalSum = arr[size-1];
  for (int i = 0; i < size-2; ++i){ 
    for (int j = i+1; j < size-1; ++j){
      a = arr[i]; b = arr[j] - arr[i]; 
      c = totalSum - arr[j];
      int max = MAX(a, MAX(b, c));
      if (max < *min) *min = max;
    }
  }
}

int main(int argc, char **argv){
  int n, min = INT_MAX;
  (void)! scanf("%d", &n);
  int *arr = safeMalloc(n*sizeof(int));
  for (int i=0; i < n; i++) {
    (void)! scanf("%d", &arr[i]);
  }
  split(arr, n, &min);
  printf("%d\n", min); 
  free(arr);
  return 0; 
}