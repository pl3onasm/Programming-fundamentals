/* 
  file: prob19.c
  author: David De Potter
  description: extra, problem 19, increasing numbers

  Approach:
    We are given a sequence of numbers, and we want the longest 
    contiguous subsequence of strictly increasing numbers we can 
    obtain after removing at most k values from the original 
    sequence.

    Let's think of the sequence as a list of positions:
      0, 1, 2, ..., n-1

    From each position i we may jump forward to a later position 
    j > i, iff the number at position j is larger than the number 
    at position i, so that the increasing property is maintained.

    Also, if we jump from i to j, then all values between them  
    must be removed in order for the chosen numbers to become  
    consecutive in the remaining sequence. The number of removals 
    needed for this jump is j - i - 1

    Since we can remove at most k values in total, we must keep 
    track of how many removals we still have left.

    So we define the function:
      best(i, r) = maximum length of an increasing chain starting 
        at index i if we still have r removals available.

    The recurrence is then:
      best(i, r) = 1 + max(best(j, r - removed))
                   for all j > i with arr[j] > arr[i] and
                   removed = j - i - 1 <= r

    We compute this using recursion + memoization, so each 
    state (i, r) is computed only once.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdint.h>
#include "../../Functions/include/clib/macros.h"

#define NA SIZE_MAX

//=================================================================
// Returns the maximum length of an increasing chain starting at
// index 'i' if we still have 'k' removals available.
size_t computeBest(size_t idx, size_t k, size_t len, int *arr, 
                   size_t **memo) {
  if (idx >= len)
    return 0;

  if (memo[idx][k] != NA)
    return memo[idx][k];

  size_t best = 1;  // at least arr[idx] itself

  for (size_t j = idx + 1; j < len; ++j) {
    if (arr[j] > arr[idx]) {
      size_t removed = j - idx - 1;
      if (removed <= k) {
        size_t candidate = 1 + computeBest(j, k - removed, len,
                                           arr, memo);
        best = C_MAX(best, candidate);
      }
    }
  }

  memo[idx][k] = best;
  return memo[idx][k];
}

//=================================================================

int main() {
  size_t len, k, best = 0, **memo;
  int *arr;

  C_READ_UNTIL_DELIM(int, arr, len, "%d", '\n');

  assert(scanf("%zu", &k) == 1);
  
  C_NEW_MATRIX_FILL(size_t, memo, len, k + 1, NA);
  
  for (size_t i = 0; i < len; ++i)
    best = C_MAX(best, computeBest(i, k, len, arr, memo));

  printf("%zu\n", best);

  C_FREE_MATRIX(memo, len);
  free(arr);

  return 0;
}
