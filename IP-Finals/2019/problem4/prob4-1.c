/* file: prob4-1.c
   author: David De Potter
   version: 4.1, in this version we use a linear search to find 
     the index of the item value in the sorted array, this type 
     of search is in O(n). The overall complexity is then in
     O(n^2) because of at most n such searches.
   description: IP final exam 2019, problem 4, 
     removing too many occurrences
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory and checks for allocation errors
void *safeCalloc (size_t n, size_t k) {
  void *p = calloc(n, k);
  if (p == NULL) {
    fprintf(stderr, "Error: calloc(%zu, %zu) failed. " 
                    "Out of memory?\n", n, k);
    exit(EXIT_FAILURE);
  }
  return p;
}

//=================================================================
// Copies a subarray arr[left..right-1] into a new array  
int *copySubArray(int *arr, int left, int right) {
  int *copy = safeCalloc((right - left), sizeof(int));
  for (int i = left; i < right; ++i) 
    copy[i - left] = arr[i];
  return copy;
}

//=================================================================
// Sorts an integer array in ascending order using merge sort
void mergeSort(int *arr, int length) {
  int l = 0, r = 0, idx = 0, mid = length / 2;
  if (length <= 1) return;
  
  int *left = copySubArray(arr, 0, mid);
  int *right = copySubArray(arr, mid, length);

  mergeSort(left, mid);
  mergeSort(right, length - mid);
  
  while (l < mid && r < length - mid) 
    if (left[l] <= right[r]) 
      arr[idx++] = left[l++];
    else 
      arr[idx++] = right[r++];

  while (l < mid)
    arr[idx++] = left[l++];

  while (r < length - mid) 
    arr[idx++] = right[r++];

  free(left);
  free(right);
}

//=================================================================
// Reads the input series into series[] and copies it into sorted[]
void processInput (int *series, int* sorted, int n) {
  for (int i = 0; i < n; ++i) {
    assert(scanf("%d%*[,]", &series[i]) == 1);
    sorted[i] = series[i];
  }
}

//=================================================================
// Prints the elements of series that occur less than k times
void printArray (int *series, int *sorted, int len, int k ) {
  int first = 1, s;
  for (int i = 0; i < len; ++i) {
    for (s = 0; s < len; ++s)         
      if (sorted[s] == series[i]) break;
    int count = 0;
    while (s < len && sorted[s] == series[i]) {
      ++s; 
      ++count;
    }
    if (count < k) {
      if (first) {
        printf("%d", series[i]); 
        first=0;
      }
      else printf(",%d", series[i]);
    }
  }
  printf("\n" );
}

//=================================================================

int main() {
  int n, k;
  assert(scanf("%d %d:", &n, &k) == 2);

  int *series = safeCalloc(n, sizeof(int));
  int *sorted = safeCalloc(n, sizeof(int));
  
  processInput (series, sorted, n);

  mergeSort (sorted, n);
  
  printArray (series, sorted, n, k);
  
  free(series);
  free(sorted);
  return 0;
}
