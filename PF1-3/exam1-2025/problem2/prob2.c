/* file: prob2.c
   author: David De Potter
   description: PF 1/3rd term 2025, problem 2, 
                summing products until stability
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// computes the transformation of n by summing the products of
// each pair of adjacent digits, from right to left
int transform(int n) {
  int sum = 0, prev = n % 10;
  n /= 10;
  while (n) {
    int d = n % 10;
    sum += d * prev;
    prev = d;
    n /= 10;
  }
  return sum;
}

//===================================================================

int main() {
  int number, iter;
  assert(scanf("%d", &number) == 1);

  iter = 0;
  while (number > 10) {
    number = transform(number);
    iter++;
  }

  printf("%d %d\n", number, iter);

  return 0;
}