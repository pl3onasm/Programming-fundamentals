/* 
  file: prob12.c
  author: David De Potter
  description: extra, problem 12, separated by distance
  time complexity: O(n log n)
  space complexity: O(n)

  Approach:
    We need the number of unique value-pairs (x, y) from the input
    such that y - x = k. Duplicates should be ignored, i.e., each
    value can only be used once in the counting.

    First, we sort the input array (O(n log n)) and then remove 
    duplicates in-place so each value appears once. On this 
    strictly increasing array, we use a two-pointer technique:
    we maintain indices left <= right and compare the difference 
    arr[right] - arr[left] to k. If the difference is too small we 
    increase right, if it is too large we increase left, and if it 
    equals k we found one unique pair and advance both pointers. 
*/

#include "../../Functions/include/clib/clib.h"

//=================================================================
// Removes duplicates from a sorted array
void removeDups(int **arr, size_t *size) {
  int *newArr = *arr;

  if (*size == 0) return;

  size_t writeIdx = 1;
  for (size_t readIdx = 1; readIdx < *size; ++readIdx) 
    if (newArr[readIdx] != newArr[readIdx - 1]) 
      newArr[writeIdx++] = newArr[readIdx];

  *size = writeIdx;
  *arr = c_safeRealloc(newArr, writeIdx * sizeof(int));
}

//=================================================================
// Counts and prints the number of pairs with difference k
void countPairsDiffK(int *arr, size_t size, size_t k) {
  size_t count = 0, left = 0, right = 0;

  while (right < size) {
    size_t diff = arr[right] - arr[left];
    if (diff < k) 
      ++right;
    else if (diff > k) 
      ++left;
    else {
      ++count;
      ++left;
      ++right;
    }
    if (left == right) 
      ++right;
  }
  printf("%zu\n", count);
}

//=================================================================

int main() {
  size_t k, size;
  assert(scanf("%zu\n", &k) == 1);

  int *arr;
  C_READ_UNTIL_DELIM(int, arr, size, "%d", '\n');

  c_mergeSort(arr, size);

  removeDups(&arr, &size);

  countPairsDiffK(arr, size, k);

  free(arr);  
  return 0;
}