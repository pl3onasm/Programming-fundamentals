/* file: prob3.c
   author: David De Potter
   description: IP Final 2022, problem 3, Goldbach
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  // returns 1 if x is prime, 0 otherwise
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2) 
    if (x % i == 0) return 0;
  return 1;
}

int main(int argc, char **argv){
  int n, count = 0; 
  (void)! scanf("%d", &n);
  for (int a = 3; a <= n/2; a += 2) {
    if (isPrime(a) && isPrime(n-a)) {
      count++; 
    }
  }
  printf("%d\n", count); 
  return 0; 
}