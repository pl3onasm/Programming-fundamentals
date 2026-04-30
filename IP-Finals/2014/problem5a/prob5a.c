/* file: prob5a.c
   author: David De Potter
   description: IP Final 2014, problem 5a, Recursive algorithms,
   recursive addition
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes the sum of a and b using recursion
int add(int a, int b){
  if (b == 0) return a;
  return add(a + 1, b - 1);
}

//=================================================================

int main() {
  int a, b;

  assert(scanf("%d %d", &a, &b) == 2);
  
  printf("%d\n", add(a, b));  
 
  return 0;
}