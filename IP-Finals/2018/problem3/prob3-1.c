/* file: prob3-1.c
   author: David De Potter
   version: 3.1, using merge sort, which causes this
      version to be in O(n log n)
   description: IP Final 2018, problem 3, sum of pairs
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
// Reallocates memory and checks for allocation errors
void* safeRealloc(void* ptr, size_t n) {
  ptr = realloc(ptr, n);
  if (ptr == NULL) {
    fprintf(stderr, "Error: realloc(%zu) failed. "
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
// Reads an integer vector from standard input and stores its size
int *readIntVector(int *size) {
  int len = 0, n, *vec = safeMalloc(*size * sizeof(int));
  while (scanf("%d", &n) == 1 && n != 0) {
    vec[len++] = n;
    if (len == *size) {
      *size *= 2;
      vec = safeRealloc(vec, *size * sizeof(int));
    }
  }
  *size = len;
  return vec;
}

//=================================================================
// Finds and prints all unique pairs of integers in vec that 
// sum to n
void getPairs(int *vec, int size, int n){
  int left = 0, right = size - 1;
  int noPair = 1;

  while (left < right) {
    int sum = vec[left] + vec[right];

    if (sum == n) {
      noPair = 0;
      printf("%d+%d\n", vec[left], vec[right]);

      int a = vec[left];
      int b = vec[right];

      while (left < right && vec[left] == a)  ++left;
      while (left < right && vec[right] == b) --right;
    }
    else if (sum < n) 
      ++left;
    else 
      --right;
  }

  if (noPair) printf("NONE\n");
}
//=================================================================

int main(){
  int size = 10, target; 
  assert(scanf("%d", &target) == 1);

  int *vec = readIntVector(&size); 
  
  mergeSort(vec, size);
  
  getPairs(vec, size, target); 
  
  free(vec); 
  return 0; 
}