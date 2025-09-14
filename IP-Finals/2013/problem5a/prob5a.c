/* file: prob5a.c
   author: David De Potter
   description: IP Final 2013, problem 5a, 
   Recursive algorithms, recursive multiplication
*/

#include <stdio.h>
#include <stdlib.h>

int mul(int a, int b) {
  if (b == 0) return 0;
  if (b > 0) return a + mul(a, b-1);
  return mul(a, b+1) - a;
}

int main(int argc, char *argv[]) {
  int a, b;
  (void)! scanf("%d %d", &a, &b);
  printf("%d\n", mul(a, b));  
  return 0;
}