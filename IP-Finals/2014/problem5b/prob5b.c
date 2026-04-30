/* file: prob5b.c
   author: David De Potter
   description: IP Final 2014, problem 5b, 
   Recursive algorithms, kth smallest element
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Swaps the values pointed to by a and b
void swap(int *a, int *b) {
  int temp = *a; 
  *a = *b; 
  *b = temp;
}

//=================================================================
// Partitions the array around a pivot (first element), and returns
// the final index of the pivot after partitioning.
// Elements less than the pivot are moved to its left,
// elements greater than or equal to the pivot to its right
int partition(int *arr, int len) {
  int idx = 1, pivot = arr[0];
  
  for (int i = 1; i < len; i++) {
    if (arr[i] < pivot){
      swap(&arr[i], &arr[idx]);
      idx++;
    }
  }
    // Place pivot in its final position
  swap(&arr[0], &arr[idx - 1]);
  return idx - 1;
}

//=================================================================
// Returns the kth smallest element in arr of given length
int kthSmallest(int k, int len, int *arr) {
  if (len == 1) 
    return arr[0];
  int p = partition(arr, len);
  if (p == k) 
    return arr[p];
  if (p < k) 
      // Search in right part and adjust k and length
    return kthSmallest(k - p - 1, len - p - 1, arr + p + 1);
  else 
      // Search in left part
    return kthSmallest(k, p, arr);
}

//=================================================================

int main() {
  int n, k, arr[500], len = 0;
  assert(scanf("%d", &k) == 1);

  while (scanf("%d", &n) == 1) 
    arr[len++] = n;
  
  printf("%d\n", kthSmallest(k, len, arr));
  
  return 0;
}