/* file: prob5.c
* author: David De Potter
* description: problem 5, remainders, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

void swap (int *a, int *b) {
  for (int i = 0; i < 2; i++) {
    int temp = a[i];
    a[i] = b[i];
    b[i] = temp;
  }
}

int main(int argc, char *argv[]) {
  int eq1[2], eq2[2], eq3[2], i, g=0;
  scanf("%d %d", &eq1[0], &eq1[1]);
  scanf("%d %d", &eq2[0], &eq2[1]);
  scanf("%d %d", &eq3[0], &eq3[1]);
  /* we want to get the maximum modulus */
  if (eq1[1] > eq2[1]) swap (eq1, eq2);
  if (eq1[1] > eq3[1]) swap (eq1, eq3);
  /* now we want to get the smallest number that satisfies 
   * tthe equation containing the largest modulus (divisor) */
  do g++;
  while (g % eq1[1] != eq1[0]);
  /* now we can skip through the rest of the numbers using the
   * largest modulus as the interval */
  for (i = g;; i+= eq1[1])
    if (i % eq2[1] == eq2[0] && i % eq3[1] == eq3[0]) break;
  printf("%d\n", i);
  return 0;
}
