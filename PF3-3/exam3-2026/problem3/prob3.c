/* 
  file: prob3.c
  author: David De Potter
  description: 3-3rd exam 2026, problem 3, minimal pair distance
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
// Reads the input from stdin and returns an array of integers
int *readInput(int *size) {
  assert(scanf("%d", size) == 1);
  int *arr = safeMalloc(*size * sizeof(int));
  for (int i = 0; i < *size; ++i) 
    assert(scanf(" %d", &arr[i]) == 1);
  return arr;
}

//===================================================================
// Copies the subarray arr[left..right] into a new array
int *copySubArray(int *arr, int left, int right) {
  int *copy = safeMalloc((right - left) * sizeof(int));
  for (int i = left; i < right; ++i) 
    copy[i - left] = arr[i];
  return copy;
}

//===================================================================
// Sorts the integer array in ascending order
void mergeSort(int *arr, int length) {
  int l = 0, r = 0, idx = 0, mid = length / 2;
  if (length <= 1) return;
  
  int *left  = copySubArray(arr, 0, mid);
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

int main(){
  int n;
  int *arr = readInput(&n);

  mergeSort(arr, n);
  
  int minDiff = arr[1] - arr[0];
  int count = 1;

  for (int i = 1; i < n - 1; ++i) {
    int diff = arr[i + 1] - arr[i];

    if (diff < minDiff) {
      minDiff = diff;
      count = 1;
    } else if (diff == minDiff) {
      ++count;
    }
  }

  printf("%d %d\n", minDiff, count);

  free(arr);
  
  return 0;
}

