/* file: prob5-2.c
   author: David De Potter
   version: 5.2, using an int function, countExps, to  
     compute partial results during recursive calls themselves
   description: IP Final 2017 Resit, problem 5, 
     sums and products
   approach: instead of generating the full expressions and 
     evaluating them afterwards, we evaluate incrementally 
     during recursion:
     - subtot keeps the sum of all finished terms (everything 
       before the current multiplication chain)
     - prod keeps the running product of the current 
       multiplication chain
     - at each digit we choose either '+' (finish the chain 
       and add it to subtot) or '*' (extend the chain)
     This avoids building strings and avoids a separate 
     evaluation pass.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Counts the number of expressions that evaluate to target
int countExps(int target, int dig, char prev, int subtot, 
              int prod){
  if (dig == 9) 
    return subtot + dig * prod == target; 

  if (prev == '*') {  // operator before dig was *
    return countExps (target, dig + 1, '+', subtot + prod * dig, 1) 
         + countExps (target, dig + 1, '*', subtot, prod * dig);    
  } else {            // operator before dig was +
    return countExps (target, dig + 1, '+', subtot + dig, 1) 
         + countExps (target, dig + 1, '*', subtot, dig);    
  }
}

//=================================================================
// Initiates the recursive counting of expressions
int prodSum(int n){
  return countExps(n, 1, '+', 0, 1);
}

//=================================================================

int main() {
  int n;
  assert(scanf("%d", &n) == 1);
  
  printf("%d\n", prodSum(n)); 
  
  return 0;
}