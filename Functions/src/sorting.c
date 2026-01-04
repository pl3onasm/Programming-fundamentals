#include "clib/sorting.h"
#include "clib/macros.h"  /* CLIB_SWAP, CLIB_MIN/MAX, alloc macros */
#include <stdlib.h>

//=================================================================
static inline int *c_copySubarray(int *const arr, size_t start, 
                                  size_t end) {
  if (end < start) 
    end = start;  

  size_t n = end - start;  
  int *copy = NULL;  
  C_NEW_ARRAY(int, copy, n);  

  for (size_t i = 0; i < n; ++i)    
    copy[i] = arr[start + i];  
  return copy;
}

//=================================================================
void c_mergeSort(int *arr, size_t len) {
  
  if (len <= 1) 
    return;  

  size_t mid = len / 2;  
  int *left  = c_copySubarray(arr, 0, mid);  
  int *right = c_copySubarray(arr, mid, len);  

  c_mergeSort(left, mid); 
  c_mergeSort(right, len - mid);  
  
  size_t l = 0, r = 0, idx = 0; 
  while (l < mid && r < len - mid)  
    if (left[l] <= right[r])
      arr[idx++] = left[l++];    
    else                    
      arr[idx++] = right[r++];  

  while (l < mid) 
    arr[idx++] = left[l++]; 
  while (r < len - mid) 
    arr[idx++] = right[r++];  
  
  free(left); 
  free(right);
}

//=================================================================
void c_bubbleSort(int *arr, size_t len) {
  for (size_t i = 0; i < len; ++i) {    
    int changed = 0;    
    for (size_t j = 0; j + 1 < len - i; ++j) {      
      if (arr[j] > arr[j + 1]) {        
        C_SWAP(arr[j], arr[j + 1]);        
        changed = 1;   
      } 
    }    
    if (!changed) 
      break;  
  }
}

//=================================================================
void c_insertionSort(int *arr, size_t len) {
  for (size_t i = 1; i < len; ++i) {    
    int key = arr[i];    
    size_t j = i;    
    while (j > 0 && arr[j - 1] > key) {      
      arr[j] = arr[j - 1];      
      --j;    
    }    
    arr[j] = key;  
  }
}

//=================================================================
void c_selectionSort(int *arr, size_t len) {
  for (size_t i = 0; i + 1 < len; ++i) {    
    size_t minIdx = i;    
    for (size_t j = i + 1; j < len; ++j)      
      if (arr[j] < arr[minIdx])
        minIdx = j;    
    C_SWAP(arr[i], arr[minIdx]);  
  }
}

//=================================================================
void c_quickSort(int *arr, size_t len) {
  
  if (len <= 1) 
    return;  

  int pivot = arr[len / 2];
  size_t i, j;

  for (i = 0, j = len - 1; ; ++i, --j) {
    while (arr[i] < pivot) ++i;
    while (arr[j] > pivot) --j;
    if (i >= j) break;
    C_SWAP(arr[i], arr[j]);
  }
  c_quickSort(arr, i);
  c_quickSort(arr + i, len - i);
}

//=================================================================
void c_countingSort(int *arr, size_t len) {
  if (len == 0) 
    return;  

  int min = arr[0], max = arr[0];

  for (size_t i = 1; i < len; ++i) {    
    min = C_MIN(min, arr[i]);   
    max = C_MAX(max, arr[i]); 
  }

  size_t range = max - min + 1;  
  int *count = NULL;  
  C_NEW_ARRAY_FILL(int, count, range, 0);  
  for (size_t i = 0; i < len; ++i)    
    count[arr[i] - min]++; 
  size_t idx = 0;  

  for (size_t i = 0; i < range; ++i)    
    for (int k = 0; k < count[i]; ++k)      
      arr[idx++] = min + (int)i; 
  
  free(count);
}