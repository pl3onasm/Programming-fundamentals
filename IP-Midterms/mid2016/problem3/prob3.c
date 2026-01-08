/* file: prob3.c
   author: David De Potter
   description: problem 3, Hamming numbers, mid2016
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if x is a Hamming number with sum of exponents equal to n
int isGoodHamming (int x, int n) {
  int sum = 0, arr[3] = {5, 3, 2};

  for (int i = 0; i < 3; ++i) 
    while (x % arr[i] == 0) {
      x /= arr[i];
      sum += 1;
    }
  return x == 1 && sum == n;
}

//=================================================================

int main() {
  int n, a, b, count = 0;

  assert(scanf("%d %d %d", &a, &b, &n) == 3);

  for(int x = a; x <= b; ++x)
    if (isGoodHamming (x, n))
      ++count;

  printf("%d\n", count);
  return 0;
}
