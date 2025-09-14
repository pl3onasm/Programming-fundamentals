/* file: prob4.c
   author: David De Potter
   description: IP Final 2022, problem 4, Intervals
*/

#include <stdio.h>
#include <stdlib.h>

void *safeMalloc (int n) {
  /* allocates n bytes of memory and checks whether the allocation
     was successful */
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

int *readIntArray(int size){
  // reads an array of size integers from stdin
  int *arr = safeMalloc(size * sizeof(int));
  for (int i=0; i < size; i++) 
    (void)! scanf("%d", &arr[i]);
  return arr;
}

void printSet(int n, int *arr){
  int i = 0;
  while (i < n) {
    printf("%d", arr[i++]); 
    int interval = 0;
    while (i < n && (arr[i] == arr[i-1] + 1 || arr[i] == arr[i-1])) {
      if (arr[i] != arr[i-1]) interval = 1;
      ++i;
    }
    if (interval) printf("..%d", arr[i-1]);  // close interval
    printf(i < n ? "," : "\n");
  }
}

int main(int argc, char **argv){
  int n; 
  (void)! scanf("%d", &n);
  int *arr = readIntArray(n);
  mergeSort(arr, n);
  printSet(n, arr);
  free(arr);
  return 0; 
}