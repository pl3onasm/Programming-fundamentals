/* file: prob3.c
   author: David De Potter
   description: IP Final 2019 resit, problem 3, 
   number of pair sums
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
    (void)! scanf("%d,", &vec[i]);
  return vec;
}

void countPairs(int *vec, int size, int k){
  int count = 0, left = 0, right = size - 1;
  while (left < right) {
    if (vec[left] + vec[right] == k) {
      count++; left++; right--;
    } else if (vec[left] + vec[right] < k) 
      left++;
    else right--;
  }
  printf("%d\n", count);
}

int main(int argc, char **argv){
  int n, k; 
  (void)! scanf("%d %d: ", &n, &k);
  int *vec = readIntVector(n); 
  mergeSort(vec, n);
  countPairs(vec, n, k); 
  free(vec);
  return 0; 
}