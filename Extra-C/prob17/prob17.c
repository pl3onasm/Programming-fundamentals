/* 
  file: prob17.c
  author: David De Potter
  description: extra, problem 17, suitcase packing
  
  Approach:
    We want to maximize the total satisfaction value, while the
    sum of chosen item sizes stays <= the suitcase capacity.

    Each item can be taken at most once, so for every item we have
    two choices, from which we pick the one that yields the 
    highest value:
      1) do not take the item
      2) take the item (only if it still fits)

    Many recursive calls repeat the same subproblems, so we store
    already computed answers in a memoization table memo[n][cap],
    where memo[n][cap] is the best value using the first n items
    with remaining capacity cap.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include "../../Functions/include/clib/macros.h"

#define NA INT_MIN

//=================================================================
// Returns the maximum value that can be obtained with a suitcase
// capacity 'cap' and 'n' items with given 'sizes' and 'values'.
int maximizeValue(size_t n, size_t cap, size_t *sizes, 
                     int *values, int **memo) {
  if (n == 0 || cap == 0)
    return 0;

  if (memo[n][cap] != NA)
    return memo[n][cap];

    // Skip item with index n-1 
  int exclude = maximizeValue(n - 1, cap, sizes, values, memo);
    
    // Take item with index n-1 if it fits
  int include = 0;
  if (sizes[n - 1] <= cap) 
    include = values[n - 1] + maximizeValue(n - 1, cap - 
                              sizes[n - 1], sizes, values, memo);

  memo[n][cap] = C_MAX(include, exclude);
  return memo[n][cap];
}

//=================================================================

int main() {
  size_t n, cap, *sizes;
  int *values, **memo;
  assert(scanf("%zu %zu", &n, &cap) == 2);

  C_NEW_ARRAY(size_t, sizes, n);
  C_NEW_ARRAY(int, values, n);

  for (size_t i = 0; i < n; i++) 
    assert(scanf("%*s %zu %d", &sizes[i], &values[i]) == 2);

  C_NEW_MATRIX_FILL(int, memo, n + 1, cap + 1, NA);

  printf("%d\n", maximizeValue(n, cap, sizes, values, memo));

  C_FREE_MATRIX(memo, n + 1);
  free(sizes);
  free(values);

  return 0;
}
