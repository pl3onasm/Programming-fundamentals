/* 
  file: prob10.c
  author: David De Potter
  description: extra, problem 10, counting cards

  Approach: dynamic programming with sliding window optimization

  We have d distinct labels. Label i has capacity caps[i] (number 
  of cards available with that label). A "hand" of size h is 
  determined by how many cards we take from each label:

    x0, x1, ..., x(d-1)  with  0 <= xi <= caps[i]  and  sum(xi) = h

  We count the number of such choices using dynamic programming.

  DP definition:
    dp[j] = number of ways to choose exactly j cards using the 
            labels processed so far

  Initialization:
    dp[0]   = 1 (one way to pick 0 cards: pick nothing)
    dp[j>0] = 0

  Transition (processing one label with capacity c):
    newdp[j] = sum_{t=0..min(c, j)} dp[j - t]

    If we take t cards from the new label, then we must take 
    (j - t) cards from the previous labels, which can be done in 
    dp[j - t] ways.

  Optimization (using a sliding window):
    The naive computation of newdp[j] does a sum of up to (c + 1) 
    terms for each j. Instead, we keep a running sum:

      window = dp[j] + dp[j-1] + ... + dp[j-c] 

    When j increases by 1, the window updates in O(1):
      - add dp[j] (the new term entering the window)
      - subtract dp[j - (c + 1)] (the term that falls out once the 
        window exceeds length (c + 1))

    This makes each label processed in O(h) time instead of 
    O(h * c), leading to a total time complexity of O(h * d).

  time complexity:  O(h * d)
  space complexity: O(h + d), since caps array uses O(d) space
    and dp, next arrays use O(h) space
*/

#include "../../Functions/include/clib/clib.h"

//=================================================================
// Reads the capacities of the d distinct labels
size_t* readCaps(size_t d){
  size_t *caps;
  C_NEW_ARRAY(size_t, caps, d);
  for(size_t i = 0; i < d; ++i)
    assert(scanf("%zu", &caps[i]) == 1);
  return caps;
}

//=================================================================
// Computes the number of hands that can be composed from a deck
// having d distinct labels with given capacities, summing up to 
// h cards
size_t getNumHands(size_t h, size_t d, size_t *caps){

  size_t *dp, *next;
    // dp[j] = #ways to choose j cards using labels processed 
    //         so far
  C_NEW_ARRAY(size_t, dp, h + 1);
    // next[j] = dp after adding the next label
  C_NEW_ARRAY(size_t, next, h + 1);

    // Base case: one way to choose 0 cards (choose nothing)
  dp[0] = 1;

    // Process each label one by one
  for(size_t i = 0; i < d; ++i){
      // Sliding window sum for the transition:
      // next[j] = dp[j] + dp[j-1] + ... + dp[j - caps[i]]
    size_t window = 0;

    for(size_t j = 0; j <= h; ++j) {

        // Add the new term entering the window: dp[j]
      window += dp[j];

        // If the window includes more than (caps[i] + 1) 
        // terms, remove the term that falls out
      if (j > caps[i])
        window -= dp[j - caps[i] - 1];

        // Set next[j] to the current window sum
      next[j] = window;
    }

      // After finishing this label, swap dp and next
    C_SWAP(dp, next);
  }
  
    // After processing all labels, dp[h] is the number 
    // of hands of size h
  size_t result = dp[h];

  free(dp);
  free(next);

  return result;
}

//=================================================================

int main(){
  size_t h, d;
  assert(scanf("%zu %zu\n", &h, &d) == 2);

  size_t *caps = readCaps(d);

  size_t nHands = getNumHands(h, d, caps);
  printf("%zu\n", nHands);

  free(caps);
  
  return 0;
}
