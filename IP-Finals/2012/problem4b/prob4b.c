/* file: prob4b.c
   author: David De Potter
   description: IP Final 2012, problem 4b, 
   Iterative algorithms, simplifying square roots
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Simplifies the square root of n and prints the result
void simplifySqrt (int n){
  int original = n;
  int prefix = 1;

  printf("sqrt(%d)=", original);

  if (n == 0){
    printf("0\n");
    return;
  }

  for (int i = 2; i * i <= n; ++i){
    while (n % (i * i) == 0){
      n /= (i * i);
      prefix *= i;
    }
  }

  if (n == 1){
    printf("%d\n", prefix);
    return;
  }

  if (prefix != 1)
    printf("%d*", prefix);

  printf("sqrt(%d)\n", n);
}

//=================================================================

int main() {
  int n; 
  assert(scanf ("%d", &n) == 1);

  simplifySqrt (n);
  
  return 0;
}