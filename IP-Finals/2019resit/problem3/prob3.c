/* file: prob3.c
   author: David De Potter
   description: IP Final 2019 resit, problem 3, 
   number of pair sums
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
  for (int i = left; i < right; ++i) 
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
  for (i = 0; i < size; ++i) 
    assert(scanf("%d%*1[,]", &vec[i]) == 1);
  return vec;
}

//=================================================================
// Counts the number of unique pairs (i, j) with i < j such that  
// vec[i] + vec[j] == k
void countPairs(int *vec, int size, int k){
  int count = 0, left = 0, right = size - 1;
  while (left < right) {
    int sum = vec[left] + vec[right];
    if (sum == k) {
      ++count; ++left; --right;
    } else if (sum < k) 
      ++left;
    else --right;
  }
  printf("%d\n", count);
}

//=================================================================

int main(){
  int n, k; 
  assert(scanf("%d %d: ", &n, &k) == 2);

  int *vec = readIntVector(n); 
  
  mergeSort(vec, n);
  
  countPairs(vec, n, k); 
  
  free(vec);
  return 0; 
}