/* file: prob2.c
   author: David De Potter
   description: extra, problem 2, pandigital divisibility
*/

#include <stdio.h>
#include <stdlib.h>

typedef unsigned long long llu;

llu toLlu(int *digits) {
  // converts the digits array to an unsigned long long
  llu result = 0;
  for (int i = 0; i < 10; ++i) 
    result = result * 10 + digits[i];
  return result;
}

void permute(int *digits, int *taken, int start, int div) {
  /* computes all permutations of the digits array and prints, in
     ascending order, those that satisfy the divisibility condition */ 
  if (start == 10) {
    llu candidate = toLlu(digits);
    if (candidate % div == 0)
      printf("%llu\n", candidate);
    return;
  }
  // recursive case
  for (int i = 0; i < 10; ++i) {
    if (!taken[i]                     // each digit can only be used once   
        && !(start == 0 && i == 0)) { // first digit cannot be 0
      ++taken[i];
      digits[start] = i;  
      permute(digits, taken, start + 1, div);
      --taken[i];                     // backtrack
    }
  }
}

int main() {
  int digits[10];
  int taken[10] = {0};

  int div; 
  (void)! scanf("%d", &div);

  permute(digits, taken, 0, div);
  
  return 0;
}
