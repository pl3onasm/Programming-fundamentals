/* file: prob4b.c
   author: David De Potter
   description: IP Final 2012, problem 4b, 
   Iterative algorithms, simplifying square roots
*/

#include <stdio.h>
#include <stdlib.h>

void simplifySqrt (int n){
  int prefix = 1;
  printf("sqrt(%d)=", n);
  for (int i = 2; i*i <= n; ++i){
    while (n % (i*i) == 0){
      n /= (i*i);
      prefix *= i;
    }
  }
  printf("%d", prefix);
  if (n > 1) printf("*sqrt(%d)", n);
  printf("\n");
}

int main(int argc, char *argv[]) {
  int n; 
  (void)! scanf ("%d", &n);
  simplifySqrt (n);
  return 0;
}