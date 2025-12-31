/* 
  file: prob13.c
  author: David De Potter
  description: extra, problem 13, joining forces
  time complexity: O(N log K), with N the total number of elements
                   and K the number of arrays

  Approach:
    Each input line is already sorted, but we receive an unknown 
    number of such lines (K) and the total number of integers (N) 
    is also unknown. So we start by reading every line into its own 
    dynamic array until we encounter an empty line. 

    To merge all these lines efficiently, we use a divide-and-
    conquer strategy: we recursively merge the left half of the 
    arrays and the right half, then merge those two sorted results. 
    Each merge is linear in the sizes of the two arrays, and the 
    recursion depth is O(log K), giving total O(N log K) time.
*/

#include "../../Functions/include/clib/clib.h"

//=================================================================
// Structure to hold an integer array and its size
typedef struct {
  int *arr;
  size_t size;
} IntArr;

//=================================================================
// Reads multiple arrays from input and returns a pointer to an
// array of IntArr. The number of arrays read is stored in nArrs.
IntArr* readArrays (size_t *nArrs) {
  size_t k = 0, cap = 0;
  IntArr *arrays = NULL;

  while (1) {

    if (k >= cap) {
      cap = (cap == 0) ? 2 : cap * 2;
      arrays = c_safeRealloc (arrays, cap * sizeof(IntArr));
    }

    int *tempArr = NULL;
    size_t n = 0;

    C_READ_UNTIL_DELIM(int, tempArr, n, "%d", '\n');

    if (n == 0) { 
      free (tempArr);
      break;
    }

    arrays[k].size = n;
    arrays[k].arr = tempArr;
    k++;
  }

  *nArrs = k;
  return arrays;
}

//=================================================================
// Merges two sorted arrays into a single sorted array and returns 
// it.
IntArr mergeArrays (IntArr arr1, IntArr arr2) {
  IntArr merged;
  merged.size = arr1.size + arr2.size;
  C_NEW_ARRAY (int, merged.arr, merged.size);

  size_t r = 0, l = 0, m = 0;

  while (r < arr1.size && l < arr2.size) {
    if (arr1.arr[r] <= arr2.arr[l]) 
      merged.arr[m++] = arr1.arr[r++];
    else 
      merged.arr[m++] = arr2.arr[l++];
  }

  while (r < arr1.size) 
    merged.arr[m++] = arr1.arr[r++];

  while (l < arr2.size) 
    merged.arr[m++] = arr2.arr[l++];

  return merged;
}

//=================================================================
// Merges multiple sorted arrays using a divide and conquer 
// approach and returns the final merged array.
IntArr merge (IntArr *arrays, size_t left, size_t right) {
  if (left == right) 
    return arrays[left];

  size_t mid = left + (right - left) / 2;

  IntArr leftArr  = merge (arrays, left, mid);
  IntArr rightArr = merge (arrays, mid + 1, right);

  IntArr merged = mergeArrays (leftArr, rightArr);

  free (leftArr.arr);
  free (rightArr.arr);
  return merged;
}

//=================================================================

int main() {
  size_t nArrs = 0;

  IntArr *arrays = readArrays (&nArrs);

  IntArr merged = merge (arrays, 0, nArrs - 1);

  C_PRINT_ARRAY (merged.arr, "%d", merged.size, " ");
  
  free (merged.arr);
  free (arrays);

  return 0;
}
