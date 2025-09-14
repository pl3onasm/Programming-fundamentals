/* file: prob4.c
   author: David De Potter
   description: IP Final 2020, problem 4, 
    minimal number of deletions
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

int *readIntVector(int size) {
  int i, *vec = safeMalloc(size*sizeof(int));
  for (i=0; i < size; i++) 
    (void)! scanf("%d", &vec[i]);
  return vec;
}

void computeDeletions(int n, int *arr1, int m, int *arr2){
  mergeSort(arr1, n);
  mergeSort(arr2, m);
  int dels = 0, i = 0, j = 0;
  while (i < n && j < m) {
    if (arr1[i] == arr2[j]) {
      i++; j++;
    } else if (arr1[i] < arr2[j]) {
      i++; dels++;
    } else {
      j++; dels++;
    }
  }
  printf("%d\n", dels + n - i + m - j); 
  // dels + remaining elements in arr1 or arr2
}

int main(int argc, char **argv){
  int n, m; 
  (void)! scanf("%d: ", &n);
  int *arr1 = readIntVector(n); 
  (void)! scanf("%d: ", &m);
  int *arr2 = readIntVector(m);
  computeDeletions(n, arr1, m, arr2);
  free(arr1); free(arr2);
  return 0; 
}