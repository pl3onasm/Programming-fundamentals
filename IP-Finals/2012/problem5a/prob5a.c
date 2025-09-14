/* file: prob5a.c
   author: David De Potter
   description: IP Final 2012, problem 5a, 
   Recursive algorithms, reaching a number,
   using brute force
*/

#include <stdio.h>
#include <stdlib.h>

int reach (int a, int n){
  if (a == n) return 1;
  if (a > n) return 0;
  return reach(a+1,n) + reach(a+3,n) + reach(a*2, n);
}

int main(int argc, char *argv[]) {
  int a, n;
  (void)! scanf("%d %d", &a, &n);  
  printf("%d\n", reach(a, n));
  return 0;
}