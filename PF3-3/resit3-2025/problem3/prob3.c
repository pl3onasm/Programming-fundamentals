/* 
  file: prob3.c
  author: David De Potter
  description: 3-3rd resit 2025, problem 3,
    maximal duplicate sum
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
  for (int i = left; i < right; ++i) 
    copy[i - left] = arr[i];
  return copy;
}

//===================================================================
// Sorts the integer array arr of given length in O(n log n) time
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
// Reads len integers from input into an array and returns it
int *readInput(int len) {
  int *arr = safeMalloc(len * sizeof(int));
  for (int i = 0; i < len; ++i) 
    assert(scanf(" %d", &arr[i]) == 1);
  return arr;
}

//===================================================================
// Returns the duplicate integer with the maximal sum of occurrences
// in the sorted array arr of given length. In case of ties, returns
// the numerically largest integer among them.
int getMaxDupInt(int *arr, int len) {
  int currInt = arr[0], currSum = arr[0];
  int maxInt = currInt, maxSum = 0, currCount = 1;

  for (int i = 1; i < len; ++i) {
    if (arr[i] == currInt) {
      currSum += arr[i];
      ++currCount;
    } else {
        // Start tracking new integer
      currInt = arr[i];
      currSum = arr[i];
      currCount = 1;
    }
    if (currCount >= 2 && (currSum > maxSum || 
        (currSum == maxSum && currInt > maxInt))) {
      maxSum = currSum;
      maxInt = currInt;
    }
  }

  return maxInt;
}

//===================================================================

int main() {
  int len;
  assert(scanf("%d:", &len) == 1);

  int *arr = readInput(len);

  mergeSort(arr, len);

  printf("%d\n", getMaxDupInt(arr, len));

  free(arr);
  
  return 0;
}