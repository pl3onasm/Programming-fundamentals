/* file: prob2.c
   author: David De Potter
   description: extra, problem 2, pandigital divisibility
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef unsigned long long llu;

//=================================================================
// Converts the digits array to an unsigned long long
llu toLlu(int *digits) {
  llu result = 0;
  for (size_t i = 0; i < 10; ++i) 
    result = result * 10 + digits[i];
  return result;
}

//=================================================================
// Recursively computes all permutations of the digits array and
// prints, in ascending order, those that satisfy the divisibility
// condition
void permute(int *digits, int *taken, size_t start, int div) {
    // base case
  if (start == 10) {
    llu candidate = toLlu(digits);
    if (candidate % div == 0)
      printf("%llu\n", candidate);
    return;
  }
    // recursive case
  for (size_t i = 0; i < 10; ++i) {
    if (!taken[i]                     // take each digit only once   
        && !(start == 0 && i == 0)) { // first digit cannot be 0
      ++taken[i];
      digits[start] = i;  
      permute(digits, taken, start + 1, div);
      --taken[i];                     // backtrack
    }
  }
}

//=================================================================

int main() {
  int digits[10];
  int taken[10] = {0};

  int div; 
  assert(scanf("%d", &div) == 1);

  permute(digits, taken, 0, div);
  
  return 0;
}
