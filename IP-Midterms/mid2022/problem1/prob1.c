/* file: prob1.c
   author: David De Potter
   description: IP mid2022, problem 1, time difference
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int h1, m1, s1, h2, m2, s2;

  assert(scanf("%d:%d:%d %d:%d:%d", 
         &h1, &m1, &s1, &h2, &m2, &s2) == 6);

  int t1 = 3600 * h1 + 60 * m1 + s1;
  int t2 = 3600 * h2 + 60 * m2 + s2;

  int d = abs(t2 - t1);

  printf("%02d:%02d:%02d\n", d / 3600, (d % 3600) / 60, d % 60);
  
  return 0;
}