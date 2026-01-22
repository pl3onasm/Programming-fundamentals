/* 
  file: prob4.c
  author: David De Potter
  description: 3-3rd resit 2025, problem 4,
    two player game

  approach:
    First note that a greedy strategy (always taking the larger
    of the two available numbers) is not optimal in general.
    A simple example is the array [8, 15, 3, 7], where greedy
    picks 8 first and loses, while optimal play picks 7 and wins.
    So we need to consider all possible game states.

    Since 1 <= n <= 25, we can use plain recursion to explore
    all possible states. Let solve(l, r) be the maximum score
    difference (current player minus other player) the current
    player can guarantee from arr[l..r]. Then we have the
    following recurrence:

      solve(l,r) = max(arr[l] - solve(l+1,r),
                       arr[r] - solve(l,r-1))

    The base case is when l == r, where the current player takes
    the only remaining element. In the end, if solve(0,n-1) > 0,
    the first player can guarantee a win.
    Of course, it does not make sense to explore both branches
    if arr[l] == arr[r].

  time complexity: O(2^n), which is acceptable for n <= 25
    Using memoization, this can be improved to O(n^2).
*/

#include <stdio.h>
#include <assert.h>

//===================================================================
// Returns the best score difference that the current player can 
// guarantee for themselves from arr[l..r]
int solve(int *arr, int l, int r) {
    
    // Base case: only one element left
  if (l == r) 
    return arr[l];

    // Both ends are equal, so only need to explore one branch
  if (arr[l] == arr[r])
    return arr[l] - solve(arr, l + 1, r);

    // Different ends, explore both branches and take the best
  int takeLeft  = arr[l] - solve(arr, l + 1, r);
  int takeRight = arr[r] - solve(arr, l, r - 1);

  return (takeLeft > takeRight) ? takeLeft : takeRight;
}

//===================================================================

int main() {
  int n, arr[25];
  
  assert(scanf("%d", &n) == 1);

  for (int i = 0; i < n; ++i)
    assert(scanf(" %d", &arr[i]) == 1);

  printf(solve(arr, 0, n - 1) > 0 ? "YES\n" : "NO\n");

  return 0;
}