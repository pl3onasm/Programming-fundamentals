/* file: prob4-2.c
* author: David De Potter
* version: 4.2, small optimization, using binary 
*   search to find the first index in the sorted array 
*   where the item value occurs, this type of search is 
*   in O(log n). However, the overall complexity is
*   still in O(n log n) because we still have to sort
* description: IP final exam 2019, problem 4, 
*   removing too many occurrences
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

int *copySubArray(int *arr, int left, int right) {
  /* copies the subarray arr[left..right] into a new array */
  int *copy = safeCalloc((right - left), sizeof(int));
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

void processInput (int *series, int* sorted, int n) {
  for (int i=0; i<n; ++i) {
    (void)! scanf("%d,", &series[i]);
    sorted[i] = series[i];
  }
}

int getFirstIndex (int *sorted, int n, int value) {
  /* get first index where value occurs in sorted
     array using binary search  */
  int left = 0, right = n, mid;
  while (left < right) {
    mid = left + (right-left)/2;
    if (sorted[mid] < value) left = mid + 1;
    else right = mid;
  }
  return left;
}

void printArray (int *series, int *sorted, int len, int k ) {
  int first = 1, s;
  for (int i=0; i<len; i++) {
    s = getFirstIndex(sorted, len, series[i]);  // binary search: O(log len)
    int count=0;
    while (s < len && sorted[s] == series[i]) {
      s++; count++;
    }
    if (count < k) {
      if (first) {printf("%d", series[i]); first=0;}
      else printf(",%d", series[i]);
    }
  }
  printf("\n" );
}

int main(int argc, char *argv[]) {
  int *series, *sorted, n, k;

  (void)! scanf("%d %d:", &n, &k);
  createArray (&series, n);
  createArray (&sorted, n);
  processInput (series, sorted, n);

  mergeSort (sorted, n);
  printArray (series, sorted, n, k);
  free(series);
  free(sorted);
  return 0;
}
