/* file: prob4a.c
   author: David De Potter
   description: IP Final 2014, problem 4a, Iterative algorithms,
   factorial sum
*/

#include <stdio.h>
#include <stdlib.h>

int isFactorialSum(int n) {
  /* checks if n equals the sum of the factorials of its digits */
  int sum = 0, fact[10], x = n;
  fact[0] = 1;
  for (int i = 1; i < 10; i++)
    // precompute factorials for 1 up to 9
    fact[i] = fact[i-1] * i;
    
  while (x > 0 && sum <= n) {
    sum += fact[x % 10];
    x /= 10;
  }
  return sum == n;
}

int main(int argc, char *argv[]) {
  int a; 
  (void)! scanf("%d", &a);
  printf(isFactorialSum(a) ? "YES\n" : "NO\n");
  return 0;
}