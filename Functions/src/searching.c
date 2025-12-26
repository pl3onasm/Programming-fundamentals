#include "clib/searching.h"


//=================================================================
int c_linSearch(int const *arr, size_t len, int key) {
  for (size_t i = 0; i < len; ++i)    
    if (arr[i] == key) 
      return (int)i;  
  return -1;
}

//=================================================================
int c_binSearch(int const *sorted, size_t len, int key) {
  size_t left = 0;  
  size_t right = len;  
  while (left < right) {   
    size_t mid = left + (right - left) / 2;    
    if (sorted[mid] == key)
      return (int)mid;    
    if (sorted[mid] < key) 
      left = mid + 1;    
    else
      right = mid;  
  }  
  return -1;
}