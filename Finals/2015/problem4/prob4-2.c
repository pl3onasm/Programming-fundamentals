/* file: prob4-2.c
   author: David De Potter
   version: 2.0, no assumption on execution times
   description: IP Final 2015, problem 4, job scheduling
*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main(int argc, char *argv[]) {
  int n, jobs[100];
  scanf("%d", &n);
  for (int i = 0; i < n; ++i) {
    scanf("%d\n", &jobs[i]);
  }
  for (int i = 0; i < n; ++i) {
    int min = INT_MAX, minIndex = 0;
    for (int j=0; j<n; ++j) {
      if (jobs[j] < min) {
        min = jobs[j];
        minIndex = j;
      }
    }
    printf("%d", minIndex+1);
    if (i < n-1) printf(",");
    jobs[minIndex] = INT_MAX;
  }
  printf("\n");
  return 0;
}