/* file: prob5-2.c
   author: David De Potter
   version: 5.2, using an int function, countExps, to  
      compute partial results during recursive calls themselves
   description: IP Final 2017 Resit, problem 5, 
      sums and products
*/

#include <stdio.h>
#include <stdlib.h>

int countExps(int target, int digit, char prev, int subtotal, int product){
  if (digit >= 9) return subtotal + 9 * product == target; 
  if (prev == '*') {  // previous operator was *
    return countExps (target, digit+1, '+', subtotal + product * digit, 1) 
         + countExps (target, digit+1, '*', subtotal, product * digit);    
  } else {            // previous operator was +
    return countExps (target, digit+1, '+', subtotal + digit, 1) 
         + countExps (target, digit+1, '*', subtotal, digit);    
  }
}

int prodSum(int n){
  return countExps(n, 1, '+', 0, 1);
}

int main(int argc, char *argv[]) {
  int n;
  (void)! scanf("%d", &n);
  printf("%d\n", prodSum(n)); 
  return 0;
}