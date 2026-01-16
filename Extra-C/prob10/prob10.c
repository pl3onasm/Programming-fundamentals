/* 
  file: prob10.c
  author: David De Potter
  description: extra, problem 10, counting cards

  Approach: 
    We want to count how many distinct hands of size h exist when 
    there are d distinct labels, and label i can be used at most 
    caps[i] times.

    A hand is determined only by how many cards of each label it 
    contains. So we count the number of solutions to:

      x0 + x1 + ... + x(d-1) = h
      with 0 <= xi <= caps[i]

    We solve this using recursion with memoization.

    For this, we define:
      ways(i, r) = number of ways to still pick r cards 
                   using labels i..d-1

    For label i, we can take:
      take = 0, 1, 2, ..., min(caps[i], r)

    and then we solve the rest recursively:
      ways(i, r) = sum over take of ways(i+1, r-take)

    Many subproblems repeat, so we store answers in memo[i][r]. 
    
*/

#include "../../Functions/include/clib/clib.h"
#include <stdint.h>

#define NA SIZE_MAX

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
size_t getNumHands(size_t i, size_t rem, size_t d, 
                   size_t *caps, size_t **memo){
  
    // base case: no more labels left
  if(i == d)
    return rem == 0;

    // return the memoized result if available
  if(memo[i][rem] != NA)
    return memo[i][rem];
    
    // recursive case: try all possible takes for label i
  size_t result = 0;

    // we can take at most min(caps[i], rem) cards of label i
  size_t maxTake = C_MIN(caps[i], rem);

  for(size_t take = 0; take <= maxTake; ++take)
    result += getNumHands(i + 1, rem - take, d, caps, memo);

    // store the result in the memoization table
  memo[i][rem] = result;

  return result;
}

//=================================================================

int main(){
  size_t h, d, **memo;

  assert(scanf("%zu %zu", &h, &d) == 2);

  size_t *caps = readCaps(d);

  C_NEW_MATRIX_FILL(size_t, memo, d + 1, h + 1, NA);

  printf("%zu\n", getNumHands(0, h, d, caps, memo));
  
  C_FREE_MATRIX(memo, d + 1);
  free(caps);
  
  return 0;
}
