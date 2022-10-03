/* file: prob3-2.c
   author: David De Potter
   description: IP Final 2019 resit, problem 3, 
   number of pair sums
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
    scanf("%d,", &vec[i]);
  }
  return vec;
}

void countPairs(int *vec, int size, int k){
  int count = 0, left = 0, right = size - 1;
  while (left < right) {
    if (vec[left] + vec[right] == k) {
      count++; left++; right--;
    } else if (vec[left] + vec[right] < k) left++;
    else right--;
  }
  printf("%d\n", count);
}

int main(int argc, char **argv){
  int n, k; 
  scanf("%d %d: ", &n, &k);
  int *vec = readIntVector(n); 
  mergeSort(n, vec);
  countPairs(vec, n, k); 
  return 0; 
}