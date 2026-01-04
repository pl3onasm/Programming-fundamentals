/* file: prob4.c
   author: David De Potter
   description: IP Final 2020, problem 4, 
    minimal number of deletions
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
// Reads an integer vector from standard input
int *readIntVector(int size) {
  int i, *vec = safeMalloc(size * sizeof(int));
  for (i=0; i < size; i++) 
    assert(scanf("%d", &vec[i]) == 1);
  return vec;
}

//=================================================================
// Computes and prints the minimal number of deletions required
// so that after deletions, the remaining elements of both arrays
// form the same multiset (and thus become identical after sorting)
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

//=================================================================

int main(){
  int n, m; 
  assert(scanf("%d: ", &n) == 1);
  int *arr1 = readIntVector(n); 
  
  assert(scanf("%d: ", &m) == 1);
  int *arr2 = readIntVector(m);
  
  computeDeletions(n, arr1, m, arr2);
  
  free(arr1); 
  free(arr2);
  return 0; 
}