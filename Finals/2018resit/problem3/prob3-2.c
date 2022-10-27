/* file: prob3.c
   author: David De Potter
   description: IP Final 2018 Resit, problem 3, ordered pairs
   version: 2.0, fast version
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

int *copySubArray(int left, int right, int arr[]) {
  int i, *copy = safeMalloc((right - left)*sizeof(int));
  for (i=left; i < right; i++) {
    copy[i - left] = arr[i];
  }
  return copy;
}

int mergeSort(int length, int arr[]) {
  int l, r, mid, idx, *left, *right, count = 0;
  if (length <= 1) {
    return 0;
  }
  mid = length/2;
  left = copySubArray(0, mid, arr);
  right = copySubArray(mid, length, arr);
  count += mergeSort(mid, left);
  count += mergeSort(length - mid, right);
  idx = 0;
  l = 0;
  r = 0;
  while ((l < mid) && (r < length - mid)) {
    if (left[l] <= right[r]) {
      // no inversions in this case
      arr[idx] = left[l];
      l++;
    } else {
      // total number of inversions to add is the number of
      // elements currently left in the left array: mid - l
      arr[idx] = right[r];
      r++; count += mid - l;
    }
    idx++;
  }
  while (l < mid) {
    arr[idx] = left[l];
    idx++;
    l++;
  }
  while (r < length - mid) {
    arr[idx] = right[r];
    idx++;
    r++;
  }
  free(left);
  free(right);
  return count; 
}

int *readIntVector (int size) {
  int *vect = safeMalloc(size * sizeof(int));
  for (int i = 0; i < size; i++)
    scanf("%d", vect + i);
  return vect;
}

int main(int argc, char **argv){
  int size; 
  scanf("%d\n", &size);
  int *vect = readIntVector(size); 
  printf("%d\n", mergeSort(size, vect));
  free(vect); 
  return 0; 
}