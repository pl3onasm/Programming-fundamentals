/* file: prob1.c
   author: David De Potter
   description: PF 1/3rd resit 2026, problem 1, Circular distance
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define MIN(a,b) ((a) < (b) ? (a) : (b))

//===================================================================

int main() {
  int a, b;

  int count = scanf("%d %d", &a, &b);
  assert(count == 2);

  int distance = abs(a - b);

  printf("%d\n", MIN(distance, 100 - distance));

  return 0;
}