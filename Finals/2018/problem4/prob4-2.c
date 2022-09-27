/* file: prob4.c
   author: David De Potter
   description: IP Final 2018, problem 4, split3
   this version uses a binary search on the solution space,
    which is the range of possible values for the maximum sum
    of a subseries
*/

#include <stdio.h>
#include <stdlib.h>

short hasSolution(int *arr, int size, int mid){
  /* verifies if there is a solution with the given mid
     as the maximum sum of the three subarrays */
  int sum = 0, count = 0;
  for (int i=0; i<size; ++i){
    if (sum + arr[i] > mid){
      if (arr[i] > mid) return 0; // no solution possible
      if (++count > 3) return 0;
      sum = arr[i];               // starts a new sum
    } else {
      sum += arr[i];              // continues the current sum
    }
  }
  return 1; // all three subseries have max sum <= mid
}


int binSearch(int *arr, int size, int low, int high){
  /* binary search for the minimum lower bound for which
     there exists a 3-way partition having that bound as 
     the maximum sum */
  while (low < high){
    int mid = low + (high-low)/2;
    if (hasSolution(arr, size, mid)) low = mid + 1;
    else high = mid;
  }
  return low;
}

int main(int argc, char **argv){
  int n, upper;
  scanf("%d", &n);
  int *arr = malloc(n*sizeof(int));
  for (int i=0; i < n; i++) {
    scanf("%d", &arr[i]);
    upper += arr[i]; 
  }
  printf("%d\n", binSearch(arr, n, 0, upper)); 
  free(arr);
  return 0; 
}