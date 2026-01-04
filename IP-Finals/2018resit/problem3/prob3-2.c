/* file: prob3.c
   author: David De Potter
   description: IP Final 2018 Resit, problem 3, ordered pairs
   version: 3.2, fast version

   We want to find the number of inversions in the array. 
   In this version we sort the array with mergesort, and count the
   number of inversions while merging. This approach gives a solution 
   in O(nlogn).  
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
  int *copy = safeMalloc((right - left)*sizeof(int));
  for (int i = left; i < right; ++i) 
    copy[i - left] = arr[i];
  return copy;
}

//=================================================================
// Adaptation of merge sort that counts the number of inversions
int countInversions(int *arr, int length) {
  int l = 0, r = 0, idx = 0, mid = length / 2, count = 0;
  if (length <= 1) return 0;
  
  int *left = copySubArray(arr, 0, mid);
  int *right = copySubArray(arr, mid, length);

  count += countInversions(left, mid);
  count += countInversions(right, length - mid);
  
  while (l < mid && r < length - mid) 
    if (left[l] <= right[r])    
        // no inversions in this case
      arr[idx++] = left[l++];
    else {                      
        // total number of inversions to add is the number of
        // elements remaining in the left subarray: mid - l         
      arr[idx++] = right[r++];  
      count += mid - l;         
    }

  while (l < mid)
    arr[idx++] = left[l++];

  while (r < length - mid) 
    arr[idx++] = right[r++];

  free(left);
  free(right);
  return count;
}

//=================================================================
// Reads an integer vector from standard input
int *readIntVector (int size) {
  int *vect = safeMalloc(size * sizeof(int));
  for (int i = 0; i < size; ++i)
    assert(scanf("%d", vect + i) == 1);
  return vect;
}

int main(){
  int size; 
  assert(scanf("%d", &size) == 1);

  int *vect = readIntVector(size);

  printf("%d\n", countInversions(vect, size));

  free(vect); 
  return 0; 
}