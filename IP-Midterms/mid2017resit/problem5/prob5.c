/* file: prob5.c
   author: David De Potter
   description: problem 5, remainders, resit mid2017
   Note:
     The standard general solution to a system of congruences is 
     the Chinese Remainder Theorem (CRT), possibly combined with 
     the extended Euclidean algorithm when moduli are not coprime. 
     Here we use a simple brute-force search that is fast enough 
     for the given test cases: we iterate over all numbers 
     satisfying one congruence (the one with the largest modulus) 
     and check the other two.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Swaps the values of two integers
void swap(int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp;
}

//=================================================================

int main(void) {
  int eq1[2], eq2[2], eq3[2];

  assert(scanf("%d %d", &eq1[0], &eq1[1]) == 2);
  assert(scanf("%d %d", &eq2[0], &eq2[1]) == 2);
  assert(scanf("%d %d", &eq3[0], &eq3[1]) == 2);
    
    // Reduce remainders modulo their moduli
  eq1[0] %= eq1[1];
  eq2[0] %= eq2[1];
  eq3[0] %= eq3[1];

    // Put the equation with the largest modulus in eq1
  if (eq1[1] < eq2[1]) { 
    swap(&eq1[0], &eq2[0]); 
    swap(&eq1[1], &eq2[1]); 
  }

  if (eq1[1] < eq3[1]) { 
    swap(&eq1[0], &eq3[0]); 
    swap(&eq1[1], &eq3[1]); 
  }
  
    // Step size to skip unnecessary candidates is the 
    // largest modulus. We assume that a solution always 
    // exists for the given input, and that i will not overflow.
  int i, start = eq1[0], step = eq1[1], found = 0;
  for (i = start; ; i += step) {
    if (i % eq2[1] == eq2[0] && i % eq3[1] == eq3[0]){
      found = 1;
      break;
    }
  }
  
  printf("%d\n", found ? i : 0);
  return 0;
}
