/* file: emirps.c
   author: David De Potter
   description: IP mid2021 resit, problem 3, lesser emirps
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime(int n) {
  if (n <= 1) return 0;
  if (n == 2) return 1;
  if (n % 2 == 0) return 0;
  for (int i = 3; i * i <= n; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

int reverse(int n) {
  int rev = 0;
  while (n > 0) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

int main(int argc, char *argv[]) {
  int a, b, count=0; 
  scanf("%d %d", &a, &b);
  for (int i = a; i <= b; i++) {
    if (isPrime(i)) {
      int rev = reverse(i);
      if (rev > i && isPrime(rev)) 
        ++count;
    } 
  }
  printf("%d\n", count); 
  return 0;
}