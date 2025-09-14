/* file: prob1.c
* author: David De Potter
* description: problem 1, reversible multiples of seven, mid2016
*/

#include <stdio.h>
#include <stdlib.h>

int reverse (int n) {
  //returns the reverse of a given number n
  int rev = 0;
  while (n) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

int main(int argc, char *argv[]) {
  int a, b, count = 0;

  (void)! scanf("%d %d", &a, &b);
  
  for (int x = a; x <= b; ++x) {
    if (x % 7 == 0 && reverse(x) % 7 == 0)
      ++count;
  }
  
  printf("%d\n", count);
  return 0;
}
