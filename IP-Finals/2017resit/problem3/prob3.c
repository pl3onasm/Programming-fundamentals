/* file: prob3.c
   author: David De Potter
   description: IP Final 2017 Resit, problem 3,
	 reordering
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory and checks for allocation errors
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    fprintf(stderr, "Error: malloc(%zu) failed. "
                    "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Copies a subarray arr[left..right-1] into a new array
int *copySubArray(int *arr, int left, int right) {
  int *copy = safeMalloc((right - left) * sizeof(int));
  for (int i = left; i < right; i++) 
    copy[i - left] = arr[i];
  return copy;
}

//=================================================================
// Sorts an integer array in ascending order using merge sort
void mergeSort(int *arr, int length) {
  int l = 0, r = 0, idx = 0, mid = length / 2;
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

//=================================================================
// Reads input arrays from standard input
int *readInput(int size){
  int *arr = safeMalloc(size * sizeof(int));
  for (int i = 0; i < size; ++i) 
    assert(scanf("%d", arr + i) == 1);
  return arr;
}

//=================================================================

int main() {
  int n; 
  assert(scanf("%d", &n) == 1);

  int *arr1 = readInput(n);
  int *arr2 = readInput(n);

  mergeSort(arr1, n);
  mergeSort(arr2, n);

  for (int i = 0; i < n; ++i) {
    if (arr1[i] != arr2[i]) {
      printf("NO\n");
      free(arr1); 
      free(arr2);
      return 0;
    }
  }
  
  printf("YES\n");

  free(arr1); 
  free(arr2);
  
  return 0;
}