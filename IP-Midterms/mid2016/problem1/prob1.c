/* file: prob1.c
   author: David De Potter
   description: problem 1, reversible multiples of seven, mid2016
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Returns the reverse of a given integer n
int reverse (int n) {
  int rev = 0;
  while (n) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

//=================================================================

int main() {
  int a, b, count = 0;

  assert(scanf("%d %d", &a, &b) == 2);
  
    // We start from the first multiple 
    // of 7 greater than or equal to a
  int start = a + (7 - a % 7) % 7; 
  
  for (int x = start; x <= b; x += 7) 
    if (reverse(x) % 7 == 0)
      ++count;
  
  printf("%d\n", count);
  return 0;
}
