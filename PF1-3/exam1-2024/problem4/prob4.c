/* file: prob4.c
   author: David De Potter
   description: PF 1/3rd term 2024, problem 4, impact
*/

#include <stdio.h>
#include <stdlib.h>

//===================================================================
// Reads the input from stdin into a histogram
void readInput(int histogram[]) {
  int x;
  while (scanf("%d", &x) == 1 && x)
    ++histogram[x];
}

//===================================================================

int main() {
  int histogram[1001] = {0};

  readInput(histogram);

  int max = 0, maxIdx = 0;

  for (int i = 0; i < 1001; ++i) {
    int impact = histogram[i] * i;
    if (impact > max) {
      max = impact;
      maxIdx = i;
    }
  }

  printf("%d\n", maxIdx);

  return 0;
}