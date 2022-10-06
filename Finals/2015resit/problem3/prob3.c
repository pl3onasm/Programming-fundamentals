/* file: prob3.c
   author: David De Potter
   description: IP Final 2015 resit, problem 3, counting emirps
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //checks if x is prime
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int reverse(int n) {
  //reverses the digits of n
  int rev = 0;
  while (n > 0) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

int main(int argc, char *argv[]) {
  int a, b; 
  scanf("%d %d", &a, &b);
  for (int i = a; i <= b; i++) {
    int rev = reverse(i);
    if (isPrime(i) && isPrime(rev) && i != rev)
      printf("%d\n", i); 
  }
  return 0;
}