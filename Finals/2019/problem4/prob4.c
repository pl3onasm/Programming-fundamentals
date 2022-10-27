/* file: prob4.c
* author: David De Potter
* description: IP final exam 2019, problem 4, 
* removing too many occurrences
*/

#include <stdio.h>
#include <stdlib.h>

void *safeCalloc (int n, int k) {
  void *p = calloc(n, k);
  if (p == NULL) {
    printf("Error: calloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return p;
}

void createArray (int **arr, int len) {
  *arr = safeCalloc(len, sizeof(int));
}

int *copySubArray(int left, int right, int arr[]) {
  int i, *copy;
  copy = safeCalloc((right - left), sizeof(int));
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

void processInput (int *series, int* sorted, int n) {
  for (int i=0; i<n; ++i) {
    scanf("%d,", &series[i]);
    sorted[i] = series[i];
  }
}

void printArray (int *series, int *sorted, int len, int k ) {
  int first = 1, s;
  for (int i=0; i<len; i++) {
    for (s=0; s<len; ++s) 
      if (sorted[s] == series[i]) break;
    int count=0;
    while (sorted[s] == series[i]) {
      s++; count++;
    }
    if (count<k) {
      if (first) {printf("%d", series[i]); first=0;}
      else printf(",%d", series[i]);
    }
  }
  printf("\n" );
}

int main(int argc, char *argv[]) {
  int *series, *sorted, n, k;

  scanf("%d %d:", &n, &k);
  createArray (&series, n);
  createArray (&sorted, n);
  processInput (series, sorted, n);

  mergeSort (n, sorted);
  printArray (series, sorted, n, k);
  free(series);
  free(sorted);
  return 0;
}
