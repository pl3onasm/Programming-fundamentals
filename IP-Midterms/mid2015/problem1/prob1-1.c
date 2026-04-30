/* file: prob1.c
   author: David De Potter
   description: problem1, multiples. mid2015
   time complexity: O(n)
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int a, b, n, count = 0;

  assert(scanf("%d %d %d", &a, &b, &n) == 3);

  for (int i = 1; i <= n; ++i)
    if (i % a == 0 && i % b == 0)
      ++count;
  
  printf("%d\n", count); 
  return 0;
}
