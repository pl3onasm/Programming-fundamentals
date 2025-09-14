/* file: prob3.c
   author: David De Potter
   description: IP Final 2017 Resit, problem 3,
	 reordering
*/

#include <stdio.h>
#include <stdlib.h>

void *safeMalloc (int n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

int *copySubArray(int *arr, int left, int right) {
  /* copies the subarray arr[left..right] into a new array */
  int *copy = safeMalloc((right - left) * sizeof(int));
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

int *readInput(int size){
  int *arr = safeMalloc(size*sizeof(int));
  for (int i=0; i < size; i++) {
    (void)! scanf("%d ", arr + i);
  }
  return arr;
}

int main(int argc, char *argv[]) {
  int n; 
  (void)! scanf("%d", &n);
  int *arr1 = readInput(n);
  int *arr2 = readInput(n);
  mergeSort(arr1, n);
  mergeSort(arr2, n);
  for (int i=0; i < n; ++i) {
    if (arr1[i] != arr2[i]) {
      printf("NO\n");
      return 0;
    }
  }
  free(arr1); free(arr2);
  printf("YES\n");
  return 0;
}