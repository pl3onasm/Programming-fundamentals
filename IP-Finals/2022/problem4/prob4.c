/* file: prob4.c
   author: David De Potter
   description: IP Final 2022, problem 4, Intervals
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
// Copies the subarray arr[left..right] into a new array
int *copySubArray(int *arr, int left, int right) {
  int *copy = safeMalloc((right - left) * sizeof(int));
  for (int i = left; i < right; ++i) 
    copy[i - left] = arr[i];
  return copy;
}

//=================================================================
// Sorts the integer array in ascending order in O(n log n) time
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
// Reads an array of size integers from stdin
int *readIntArray(int size){
  int *arr = safeMalloc(size * sizeof(int));
  for (int i = 0; i < size; ++i)
    assert(scanf("%d", &arr[i]) == 1);
  return arr;
}

//=================================================================
// Prints the set represented by the sorted array arr (which may 
// contain duplicates) in a compact format using intervals
void printSet(int n, int *arr){
  int i = 0;
  while (i < n) {
    printf("%d", arr[i++]); 
    int interval = 0;
    while (i < n && (arr[i] == arr[i - 1] + 1 
                     || arr[i] == arr[i - 1])) {
      if (arr[i] != arr[i - 1]) 
        interval = 1;
      ++i;
    }
    if (interval) printf("..%d", arr[i - 1]);  // close interval
    printf(i < n ? "," : "\n");
  }
}

//=================================================================

int main(){
  int n; 
  assert(scanf("%d", &n) == 1);

  int *arr = readIntArray(n);

  mergeSort(arr, n);

  printSet(n, arr);

  free(arr);
  return 0; 
}