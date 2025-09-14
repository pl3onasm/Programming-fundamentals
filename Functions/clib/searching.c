#include "clib.h"

  // linear search: searches for key in arr and 
  // returns its index if found, otherwise returns -1
int linSearch(int *arr, int len, int key) {
  int i;
  for (i = 0; i < len; ++i) 
    if (arr[i] == key) return i;
  return -1;
}

  // binary search: searches for key in **sorted** array 
  // and returns its index if found, otherwise returns -1
int binSearch(int *sorted, int len, int key) {
  int left = 0, right = len, mid;
  while (left < right) {
    mid = left + (right - left)/2;
    if (sorted[mid] == key) return mid;
    else if (sorted[mid] < key) left = mid + 1;
    else right = mid;
  }
  return -1;
}
