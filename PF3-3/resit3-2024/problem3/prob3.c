/* 
  file: prob3.c
  author: David De Potter
  description: 3-3rd resit exam 2024, problem 3,
    pair difference
*/

#include <stdio.h>
#include <stdlib.h>

int *copySubArray(int *arr, int left, int right) {
  // copies the subarray arr[left..right] into a new array
  int *copy = malloc((right - left) * sizeof(int));
  for (int i = left; i < right; i++) 
    copy[i - left] = arr[i];
  return copy;
}

void mergeSort(int *arr, int length) {
  // sorts an array of integers in O(n log n) time
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

int *readArray(int n) {
  // reads n integers from stdin into an array
  int *arr = malloc(n * sizeof(int));
  for (int i = 0; i < n; i++) 
    (void)! scanf("%d", &arr[i]);
  return arr;
}

int countPairs(int *arr, int n, int k) {
  // counts the number of pairs in arr 
  // with difference <= k
  int count = 0;
  for (int i = 0; i < n; i++) 
    for (int j = i + 1; j < n && arr[j] - arr[i] <= k; j++) 
      ++count;
  return count;
}

int main(){
  int n, k;
  (void)! scanf("%d %d:", &k, &n);

  int *arr = readArray(n);

  mergeSort(arr, n);

  printf("%d\n", countPairs(arr, n, k));

  free(arr);
  return 0; 
}