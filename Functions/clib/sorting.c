#include "clib.h"

  // copies the subarray arr[left..right] into a new array;
  // needed for mergeSort and is given on the exam
int *copySubArray(int *arr, int left, int right) {
  CREATE_ARRAY(int, copy, right - left, 0);
  for (int i = left; i < right; i++) 
    copy[i - left] = arr[i];
  return copy;
}

  // sorts an array of integers in O(n log n) time;
  // this function is given on the exam
void mergeSort(int *arr, int length) {
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

  // sorts an array of integers in O(n²) time
void bubbleSort(int *arr, int len) {
  int i, j, change;
  for (i = 0; i < len; ++i) {
    change = 0;
    for (j = 0; j+1 < len - i; ++j) {
      if (arr[j] > arr[j+1]) {
        SWAP(arr[j], arr[j+1]);
        change = 1;
      }
    }
    if (! change) break;
  }
}

  // sorts an array of integers in O(n²) time
void insertionSort(int *arr, int len) {
  int i, j, key;
  for (i = 1; i < len; ++i) {
    key = arr[i];
    j = i-1;
    while (j >= 0 && arr[j] > key) {
      arr[j+1] = arr[j];
      j--;
    }
    arr[j+1] = key;
  }
}

  // sorts an array of integers in O(n²) time
void selectionSort(int *arr, int len) {
  int i, j, min;
  for (i = 0; i < len-1; ++i) {
    min = i;
    for (j = i+1; j < len; ++j) 
      if (arr[j] < arr[min]) min = j;
    SWAP(arr[i], arr[min]);
  }
}

  // sorts an array of integers in expected ϴ(n log n);
  // worst-case performance, however, is in ϴ(n²) 
void quickSort(int *arr, int len) {
  int i, j, pivot;
  if (len <= 1) return;
  pivot = arr[len/2];
  for (i = 0, j = len-1; ; ++i, --j) {
    while (arr[i] < pivot) ++i;
    while (arr[j] > pivot) --j;
    if (i >= j) break;
    SWAP(arr[i], arr[j]);
  }
  quickSort(arr, i);
  quickSort(arr+i, len-i);
}

  // sorts an array of integers in O(n) time;
  // assumes the range is not too large
void countingSort(int *arr, int length) {
  int min, max, range, i, j, idx = 0;
  min = max = arr[0];
  for (i = 1; i < length; i++) {
    min = MIN (arr[i], min);
    max = MAX (arr[i], max);
  }
  range = max - min + 1;
  CREATE_ARRAY(int, count, range, 0);
  for (i = 0; i < length; i++) 
    count[arr[i] - min]++;
  for (i = 0; i < range; i++) 
    for (j = 0; j < count[i]; j++)
      arr[idx++] = min + i; 
  free(count);
}