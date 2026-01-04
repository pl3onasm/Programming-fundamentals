/* 
  file: prob3.c
  author: David De Potter
  description: 3-3rd resit exam 2024, problem 3,
    pair difference
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Allocates memory for n bytes, exits if malloc fails
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    fprintf(stderr, "Error: malloc(%zu) failed. "
                    "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//===================================================================
// Copies the subarray arr[left..right] into a new array
int *copySubArray(int *arr, int left, int right) {
  int *copy = safeMalloc((right - left) * sizeof(int));
  for (int i = left; i < right; i++) 
    copy[i - left] = arr[i];
  return copy;
}

//===================================================================
// Sorts the integer array arr of given length in O(n log n) time
void mergeSort(int *arr, int length) {
  int l = 0, r = 0, idx = 0, mid = length/2;
  if (length <= 1) return;
  
  int *left = copySubArray(arr, 0, mid);
  int *right = copySubArray(arr, mid, length);

  mergeSort(left, mid);
  mergeSort(right, length - mid);
  
  while (l < mid && r < length - mid) 
    if (left[l] <= right[r]) 
      arr[idx++] = left[l++];
    else 
      arr[idx++] = right[r++];

  while (l < mid)
    arr[idx++] = left[l++];

  while (r < length - mid) 
    arr[idx++] = right[r++];

  free(left);
  free(right);
}

//===================================================================
// Reads n integers from stdin into an array
int *readArray(int n) {
  int *arr = safeMalloc(n * sizeof(int));
  for (int i = 0; i < n; ++i) 
    assert(scanf("%d", &arr[i]) == 1);
  return arr;
}

//===================================================================
// Counts the number of pairs (i,j) with i < j and 
// arr[j] - arr[i] <= k. Assumes arr is sorted in non-decreasing 
// order
int countPairs(int *arr, int n, int k) {
  int count = 0, right = 1;

  for (int left = 0; left < n; ++left) {
    if (right < left + 1) right = left + 1;
    
    while (right < n && arr[right] - arr[left] <= k)
      ++right;

    count += right - left - 1;
  }
    
  return count;
}

//===================================================================

int main(){
  int n, k;
  assert(scanf("%d %d:", &k, &n) == 2);

  int *arr = readArray(n);

  mergeSort(arr, n);

  printf("%d\n", countPairs(arr, n, k));

  free(arr);
  return 0; 
}