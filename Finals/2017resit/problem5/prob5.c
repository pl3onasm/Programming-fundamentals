/* file: prob5.c
   author: David De Potter
   description: IP Final 2017 Resit, problem 5, 
   sums and products
*/

#include <stdio.h>
#include <stdlib.h>

void generateExpressions(char ops[], int n, int index, int *count){
  if (index > 7) {      // all 8 operators have been set
    int eval=0, digits[9] = {1,2,3,4,5,6,7,8,9}; 
    for (int i = 0; i < 8; ++i){  // evaluate products first
      if (ops[i] == '*') {
        digits[i+1] = digits[i]*digits[i+1];
        digits[i] = 0;  // cannot be used in below summation anymore
      }
    }
    for (int i = 0; i < 9; ++i) eval += digits[i];
    if (eval == n) (*count)++;
    return;
  }
  ops[index] = '+';
  generateExpressions(ops, n, index+1, count);
  ops[index] = '*';
  generateExpressions(ops, n, index+1, count);
}

int prodSum(int n){
  int count=0; char ops[8];
  generateExpressions(ops, n, 0, &count); 
  return count; 
}

int main(int argc, char *argv[]) {
  int n;
  scanf("%d", &n);
  printf("%d\n", prodSum(n)); 
  return 0;
}