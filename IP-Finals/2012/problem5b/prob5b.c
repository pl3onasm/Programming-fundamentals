/* file: prob5b.c
   author: David De Potter
   description: IP Final 2012, problem 5b, 
   Recursive algorithms, reaching a number using
    memoization to optimize performance as compared to prob5a.c
    Thanks to memoization, this version runs in linear time 
    instead of exponential time.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory and checks if it was successful
void *safeCalloc (size_t n, size_t size) {
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    fprintf(stderr, "Error: calloc(%zu, %zu) failed. "
                    "Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Recursively computes the number of ways to reach n from a
// using the allowed operations: +1, +3, *2 with memoization
int mReach (int a, int n, int *memo) {
    // If reached n, found one more way
  if (a == n) 
    return 1;
    // If overshot n, no way to reach n
  if (a > n) 
    return 0;
    // If not yet computed, compute and store result
  if (memo[a] == -1) 
    memo[a] = mReach(a + 1, n, memo) + mReach(a + 3, n, memo) 
            + mReach(a * 2, n, memo);
    // Return the stored result
  return memo[a];
}

//=================================================================
// Initiates the recursive computation with memoization
int reach (int a, int n){
  int *memo = safeCalloc(n + 1, sizeof(int));
    // Initialize memoization array with -1 (indicating uncomputed)
  for (int i = 0; i <= n; ++i) 
    memo[i] = -1;
  int res = mReach(a, n, memo);
  free(memo);
  return res;
}

//=================================================================

int main() {
  int a, n;

  assert(scanf("%d %d", &a, &n) == 2);
  
  printf("%d\n", reach(a, n));
  
  return 0;
}