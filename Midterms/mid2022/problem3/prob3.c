/* file: prob3.c
   author: David De Potter
   description: IP mid2022, problem 3, perfect product
   Note: you could also replace 
      return sqrt(p) == floor(sqrt(p))
    by one of these expressions: 
      return sqrt(p) == (int) sqrt(p)
      return (int) sqrt(p) * (int) sqrt(p) == p
      return sqrt(p) == roundl(sqrtl(p))
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int isPerfectSquare(int a, int b){
  long p = (long)a*b; 
  return sqrt(p) == floor(sqrt(p)); 
}

int main(int argc, char *argv[]) {
  int a, b=1; 
  scanf("%d", &a);
  for (b = 1; b <= a; ++b) { 
    if (isPerfectSquare(a,b)) break;
  }
  printf("%d\n", b); 
  return 0;
}