/* file: prob3.c
   author: David De Potter
   description: IP Final 2017, problem 3, Missing number
   You could opt for a solution using a sort and then a 
   linear search, but then we are in O(n log n) time at best.
   We can do better by just computing the sum over the array
   and then subtracting this from the sum of first n natural
   numbers, given by n*(n+1)/2. The result is the missing number. 
   This way we are in linear time.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int n, x, arraySum = 0;
  assert(scanf("%d", &n) == 1);
  
  for (int i = 0; i < n; ++i) {
    assert(scanf("%d", &x) == 1);
    arraySum += x;
  }
  
  int total = n * (n + 1) / 2;    // sum of 0..n
  
  printf("%d\n", total - arraySum);

  return 0;
}