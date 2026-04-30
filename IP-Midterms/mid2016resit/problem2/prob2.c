/* file: prob2.c
   author: David De Potter
   description: problem 2, sorting numbers, resit mid2016
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int numbers[100] = {0}, n, last = 0;

  assert(scanf("%d", &n) == 1);
 
  while (n) {
    ++numbers[n];
    ++last;
    assert(scanf("%d", &n) == 1);
  }
  
  int count = 0;
  for (int i = 99; i > 0; --i) {
    for (int j = 0; j < numbers[i]; ++j) {
      printf("%d", i);
      if (++count < last) printf(",");
    }
  }
  
  printf("\n");
  return 0;
}
