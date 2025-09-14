/* 
  file: prob3.c
  author: David De Potter
  description: PF 3/3rd term 2025, problem 3, 
               Counting pair sums
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Allocates memory for n bytes, exits if malloc fails
void *safeMalloc (int n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//===================================================================
// Reads the input from stdin and returns an array of integers
int *readInput(int *size) {
  assert(scanf("%d:", size) == 1);
  int *arr = safeMalloc(*size * sizeof(int));
  for (int i = 0; i < *size; i++) 
    assert(scanf("%d", &arr[i]) == 1);
  return arr;
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
// Sorts the array arr using the merge sort algorithm
void mergeSort(int *arr, int length) {
  int l = 0, r = 0, idx = 0, mid = length/2;
  if (length <= 1) return;
  
  int *left = copySubArray(arr, 0, mid);
  int *right = copySubArray(arr, mid, length);

  mergeSort(left, mid);
  mergeSort(right, length - mid);
  
  while (l < mid && r < length - mid) {
    if (left[l] < right[r]) 
      arr[idx++] = left[l++];
    else 
      arr[idx++] = right[r++];
  }

  while (l < mid)
    arr[idx++] = left[l++];

  while (r < length - mid) 
    arr[idx++] = right[r++];

  free(left);
  free(right);
}

//===================================================================
// Counts the number of pairs (a,b) in arr for which a + b >= n
void countPairs(int *arr, int size, int n) {
  int count = 0, l = 0, r = size - 1;
  while (l < r) {
    if (arr[l] + arr[r] >= n) {
      count += r - l;
      r--;
    } else l++;
  }
  printf("%d\n", count);
}

//===================================================================

int main() {
  int size, n;

  assert(scanf("%d", &n) == 1);
  int *arr = readInput(&size);

  mergeSort(arr, size);

  countPairs(arr, size, n);

  free(arr);
  
  return 0;
}