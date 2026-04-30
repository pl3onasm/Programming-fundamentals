/* file: prob2.c
   author: David De Potter
   description: extra, problem 2, pandigital divisibility

   Approach:
    We must print all 10-digit pandigital numbers (containing 
    digits 0..9 exactly once) that are divisible by the given 
    divisor d. Numbers with a leading 0 are not allowed, and 
    the output must be in ascending order without sorting.

    We generate these numbers by recursive backtracking. At each 
    position we try the digits 0..9 in increasing order. This 
    produces the 10-digit numbers in lexicographic order.

    In order to check divisibility, we maintain the remainder of 
    the currently constructed prefix modulo d. If the prefix has 
    remainder rem, then after appending a digit x, the new 
    remainder is:
        nextRem = (rem * 10 + x) % d.
    When we have constructed a full 10-digit number, we check if 
    the final remainder is 0, in which case we print the number.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Recursively computes all permutations of the digits array and
// prints, in ascending order, those that satisfy the divisibility
// condition
void permute(int *digits, int *taken, size_t pos, 
             int div, int rem) {

    // base case: full 10-digit pandigital number constructed
  if (pos == 10) {
    if (rem == 0) {
      for (size_t i = 0; i < 10; ++i)
        printf ("%d", digits[i]);
      printf ("\n");
    }
    return;
  }

    // recursive case: try each digit that has not yet been taken
  for (int digit = 0; digit < 10; ++digit) {
    if (!taken[digit]                     // take each digit once   
        && !(pos == 0 && digit == 0)) {   // no leading 0
      
        // choose digit
      taken[digit] = 1;
      digits[pos] = digit;  
      
        // update remainder for the extended prefix number
      int nextRem = ((long long)rem * 10 + digit) % div;
          
        // recurse to fill the next position
      permute(digits, taken, pos + 1, div, nextRem);
        
        // backtrack: undo the choice
      taken[digit] = 0;                 
    }
  }
}

//=================================================================

int main() {
  int digits[10];
  int taken[10] = {0};

  int div; 
  assert(scanf("%d", &div) == 1);

  permute(digits, taken, 0, div, 0);
  
  return 0;
}
