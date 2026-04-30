/* file: prob1.c
   author: David De Potter
   description: IP mid2021 resit, problem 1, light numbers
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int n, sum = 0, digit, max = 0; 
  assert(scanf("%d", &n) == 1);

  while (n > 0) {
    digit = n % 10;
    n /= 10;
    sum += digit;
    if (digit > max) 
      max = digit;
  }
  
  printf(sum - max < max ? "YES\n" : "NO\n");
  
  return 0;
}
