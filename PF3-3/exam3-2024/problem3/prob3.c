/* 
  file: prob3.c
  author: David De Potter
  description: PF 3/3rd term 2024, problem 3, Largest contiguous selection
*/

#include <stdio.h>
#include <stdlib.h>

void *safeMalloc (int n) {
  /* allocates memory and checks whether this was successful */
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

int *readInput(int *size) {
  /* reads the input from stdin */
  (void)! scanf("%d:", size);
  int *arr = safeMalloc((*size + 1) * sizeof(int));
  for (int i = 0; i < *size; i++) 
    (void)! scanf("%d", &arr[i]);
  return arr;
}

int *copySubArray(int *arr, int left, int right) {
  /* copies the subarray arr[left..right] into a new array */
  int *copy = safeMalloc((right - left)*sizeof(int));
  for (int i = left; i < right; i++) 
    copy[i - left] = arr[i];
  return copy;
}

void mergeSort(int *arr, int length) {
  /* sorts an array of integers in O(n log n) time */
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

void selectLargest(int *arr, int size) {
  arr[size] = arr[size - 1] + 2;  // sentinel to force final break
  int max = 0, sum = 1, start = 0,
      maxStart = 0, maxEnd = 0;

  for (int i = 1; i <= size; i++) {
    if (arr[i] == arr[i - 1] || arr[i] == arr[i - 1] + 1) {
      ++sum;
    } else {
      if (sum > max) {
        max = sum;
        maxStart = start;
        maxEnd = i - 1;
      }
      sum = 1;
      start = i;
    }
  }

  printf("%d: [%d,%d)\n", max, arr[maxStart], arr[maxEnd] + 1);
}

int main(int argc, char *argv[]) {
  int size;

  int *arr = readInput(&size);

  mergeSort(arr, size);

  selectLargest(arr, size);

  free(arr);
  
  return 0;
}