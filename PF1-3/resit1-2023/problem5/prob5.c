/* file: prob5.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 5, most frequent value
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================

int main() {
  int a, b, ints[10001] = {0};

    // read the intervals and update counts
  while (scanf("%d %d", &a, &b) == 2 && (a || b)){
    ++ints[a];
    --ints[b];
  }

    // calculate the cumulative sum and track
    // smallest index with maximum frequency
  int max = 0, maxFreq = ints[0];
  for (int i = 1; i < 10000; ++i) {
    ints[i] += ints[i - 1];
    if (ints[i] > maxFreq) {
      maxFreq = ints[i];
      max = i;
    }
  }

  printf("%d\n", max);
  return 0;
}