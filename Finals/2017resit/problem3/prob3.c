/* file: prob3.c
   author: David De Potter
   description: IP Final 2017 Resit, problem 3,
	 reordering
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

void mergeSort(int length, int arr[]) {
  int l, r, mid, idx, *left, *right;
  if (length <= 1) {
    return;
  }
  mid = length/2;
  left = copySubArray(0, mid, arr);
  right = copySubArray(mid, length, arr);
  mergeSort(mid, left);
  mergeSort(length - mid, right);
  idx = 0;
  l = 0;
  r = 0;
  while ((l < mid) && (r < length - mid)) {
    if (left[l] < right[r]) {
      arr[idx] = left[l];
      l++;
    } else {
      arr[idx] = right[r];
      r++;
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
}

int *readInput(int size){
  int *arr = safeMalloc(size*sizeof(int));
  for (int i=0; i < size; i++) {
    scanf("%d ", arr + i);
  }
  return arr;
}

int main(int argc, char *argv[]) {
  int n; 
  scanf("%d", &n);
  int *arr1 = readInput(n);
  int *arr2 = readInput(n);
  mergeSort(n, arr1);
  mergeSort(n, arr2);
  for (int i=0; i < n; ++i) {
    if (arr1[i] != arr2[i]) {
      printf("NO\n");
      return 0;
    }
  }
  free(arr1); free(arr2);
  printf("YES\n");
  return 0;
}