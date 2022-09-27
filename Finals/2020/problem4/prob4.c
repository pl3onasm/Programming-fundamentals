/* file: prob4.c
   author: David De Potter
   description: IP Final 2020, problem 4, 
    minimal number of deletions
*/

#include <stdio.h>
#include <stdlib.h>

int *copySubArray(int left, int right, int arr[]) {
  int i, *copy = malloc((right - left)*sizeof(int));
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

int *readIntVector(int size) {
  int i, *vec = malloc(size*sizeof(int));
  for (i=0; i < size; i++) {
    scanf("%d", &vec[i]);
  }
  return vec;
}

void computeDeletions(int n, int *arr1, int m, int *arr2){
  mergeSort(n, arr1);
  mergeSort(m, arr2);
  int dels = 0, i = 0, j = 0;
  while (i < n && j < m) {
    if (arr1[i] == arr2[j]) {
      i++; j++;
    } else if (arr1[i] < arr2[j]) {
      i++; dels++;
    } else {
      j++; dels++;
    }
  }
  printf("%d\n", dels + n - i + m - j); 
  // dels + remaining elements in arr1 or arr2
}

int main(int argc, char **argv){
  int n, m; 
  scanf("%d: ", &n);
  int *arr1 = readIntVector(n); 
  scanf("%d: ", &m);
  int *arr2 = readIntVector(m);
  computeDeletions(n, arr1, m, arr2);
  free(arr1); free(arr2);
  return 0; 
}