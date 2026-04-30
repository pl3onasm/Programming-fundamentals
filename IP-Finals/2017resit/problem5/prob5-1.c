/* file: prob5-1.c
   author: David De Potter
   version: 5.1, using a void function, generating expressions
      and evaluating them at the end
   description: IP Final 2017 Resit, problem 5, 
      sums and products
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Generates all possible expressions by placing '+' or '*'
// operators between the digits 1 to 9, evaluates them,
// and counts how many evaluate to n
void generateExpressions(char ops[], int n, int idx, int *count){
    
    // base case: all operators have been set
  if (idx > 7) {      
    int eval = 0, digits[] = {1,2,3,4,5,6,7,8,9}; 
    for (int i = 0; i < 8; ++i){  
        // evaluate products first
      if (ops[i] == '*') {
        digits[i + 1] = digits[i] * digits[i + 1];
          // mark digit as used, so it is not added later
        digits[i] = 0;  
      }
    }
      // sum up remaining digits
    for (int i = 0; i < 9; ++i) 
      eval += digits[i];
      // check if evaluation matches n
    if (eval == n) 
      ++*count;
    return;
  }

    // recursive case: set operator at position idx to '+' or '*'
  ops[idx] = '+';
  generateExpressions(ops, n, idx + 1, count);
  ops[idx] = '*';
  generateExpressions(ops, n, idx + 1, count);
}

//=================================================================
// Initiates the generation of expressions and counting
int prodSum(int n){
  int count = 0; char ops[8];
  generateExpressions(ops, n, 0, &count); 
  return count; 
}

//=================================================================

int main() {
  int n;
  assert(scanf("%d", &n) == 1);

  printf("%d\n", prodSum(n)); 
  
  return 0;
}