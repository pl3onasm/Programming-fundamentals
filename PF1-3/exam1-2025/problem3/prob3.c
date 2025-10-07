/* file: prob3.c
   author: David De Potter
   description: PF 1/3rd term 2025, problem 3, 
                Pisano numbers
   note: we make use of the fact that 
         (a + b) mod m = ((a mod m) + (b mod m)) mod m
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================

int main() {
  int m;
  assert(scanf("%d", &m) == 1);

  // edge case: m = 1 --> sequence is 0, 0, 0,... period = 1
  if (m == 1) {
    printf("1\n");
    return 0;
  }

  int a = 0, b = 1, c, period = 0;

  do {
    c = (a + b) % m;
    a = b;
    b = c;
    period++;
  } while (!(a == 0 && b == 1));

  printf("%d\n", period);

  return 0;
}