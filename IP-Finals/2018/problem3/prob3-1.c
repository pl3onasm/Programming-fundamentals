/* file: prob3-1.c
   author: David De Potter
   version: 3.1, using merge sort, which causes this
      version to be in O(n log n)
   description: IP Final 2018, problem 3, sum of pairs
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

void* safeRealloc(void* ptr, int n) {
  ptr = realloc(ptr, n);
  if (ptr == NULL) {
    printf("Error: realloc(%d) failed. Out of memory?\n", n);
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

int *readIntVector(int *size) {
  int len=0, n, *vec = safeMalloc(*size*sizeof(int));
  while (scanf("%d", &n) && n != 0) {
    vec[len++] = n;
    if (len == *size) {
      *size *= 2;
      vec = safeRealloc(vec, *size*sizeof(int));
    }
  }
  *size = len;
  return vec;
}

void getPairs(int *vec, int size, int n){
  int left = 0, right = size - 1, noPair = 1;
  while (left < right) {
    if (vec[left] + vec[right] == n) {
      if (vec[left+1] == vec[left]){
        left++; continue;   // skip duplicates
      }
      if (vec[right-1] == vec[right]) {
        right--; continue;  // skip duplicates
      }
      noPair = 0; 
      printf("%d+%d\n", vec[left], vec[right]);
      left++; right--;
    } else if (vec[left] + vec[right] < n) left++;
    else right--;
  }
  if (noPair) printf("NONE\n");
}

int main(int argc, char **argv){
  int size=10, target; 
  (void)! scanf("%d\n", &target);
  int *vec = readIntVector(&size); 
  mergeSort(vec, size);
  getPairs(vec, size, target); 
  free(vec); 
  return 0; 
}