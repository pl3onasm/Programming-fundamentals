/* file: prob3.c
   author: David De Potter
   description: IP Final 2018, problem 3, sum of pairs
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

int *readIntVector(int *size) {
  int len=0, n, *vec = malloc(*size*sizeof(int));
  while (scanf("%d", &n) && n != 0) {
    vec[len++] = n;
    if (len == *size) {
      *size *= 2;
      vec = realloc(vec, *size*sizeof(int));
    }
  }
  *size = len;
  return vec;
}

void getPairs(int *vec, int size, int n){
  int left = 0, right = size - 1, flag = 1;
  while (left < right) {
    if (vec[left] + vec[right] == n) {
      if (vec[left] == vec[left-1]){
        left++; continue;   // skip duplicates
      }
      if (vec[right] == vec[right+1]) {
        right--; continue;  // skip duplicates
      }
      flag = 0; 
      printf("%d + %d\n", vec[left], vec[right]);
      left++; right--;
    } else if (vec[left] + vec[right] < n) left++;
    else right--;
  }
  if (flag) printf("NONE\n");
}

int main(int argc, char **argv){
  int size=10, target; 
  scanf("%d\n", &target);
  int *vec = readIntVector(&size); 
  mergeSort(size, vec);
  getPairs(vec, size, target); 
  free(vec); 
  return 0; 
}