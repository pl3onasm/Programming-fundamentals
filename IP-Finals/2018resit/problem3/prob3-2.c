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

int countInversions(int *arr, int length) {
  /* sorts an array of integers in O(n log n) time */
  int l = 0, r = 0, idx = 0, mid = length/2, count = 0;
  if (length <= 1) return 0;
  
  int *left = copySubArray(arr, 0, mid);
  int *right = copySubArray(arr, mid, length);

  count += countInversions(left, mid);
  count += countInversions(right, length - mid);
  
  while (l < mid && r < length - mid) {
    if (left[l] <= right[r])    // no inversions in this case
      arr[idx++] = left[l++];
    else {                      // total number of inversions to add               
      arr[idx++] = right[r++];  // is the number of elements currently 
      count += mid - l;         // left in the left subarray: mid - l
    }
  }

  while (l < mid)
    arr[idx++] = left[l++];

  while (r < length - mid) 
    arr[idx++] = right[r++];

  free(left);
  free(right);
  return count;
}

int *readIntVector (int size) {
  int *vect = safeMalloc(size * sizeof(int));
  for (int i = 0; i < size; i++)
    (void)! scanf("%d", vect + i);
  return vect;
}

int main(int argc, char **argv){
  int size; 
  (void)! scanf("%d\n", &size);
  int *vect = readIntVector(size); 
  printf("%d\n", countInversions(vect, size));
  free(vect); 
  return 0; 
}