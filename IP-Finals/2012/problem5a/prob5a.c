/* file: prob5a.c
   author: David De Potter
   description: IP Final 2012, problem 5a, 
   Recursive algorithms, reaching a number,
   using brute force
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Recursively computes the number of ways to reach n from a
// using the allowed operations: +1, +3, *2
int reach (int a, int n){
    // If reached n, found one more way
  if (a == n) 
    return 1;
    // If overshot n, no way to reach n
  if (a > n)  
    return 0;
    // Recursive case: sum all branches that try each 
    // operation in order to reach n
  return reach(a + 1, n) + reach(a + 3, n) + reach(a * 2, n);
}

//=================================================================

int main() {
  int a, n;

  assert(scanf("%d %d", &a, &n) == 2);

  printf("%d\n", reach(a, n));

  return 0;
}