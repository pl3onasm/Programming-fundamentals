/* file: prob3.c
* author: David De Potter
* description: problem 3, takuzu numbers, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int checkIfTakuzu (int n) {
  /* checks to see if n meets the Takuzu criteria */
  int count0 = 0, count1 = 0, countAdj1 = 0, countAdj0 = 0;

  while (n) {
    if (n & 1) {
      count1++;
      countAdj1++;
      countAdj0 = 0;
    } else {
      count0++;
      countAdj1 = 0;
      countAdj0++;
    }
    if (countAdj1 > 2 || countAdj0 > 2) return 0;
    n >>= 1;
  }

  return count1 == count0;
}

int main(int argc, char *argv[]) {
  int n, index = 0, number = 1;

  (void)! scanf("%d", &n);
  
  while (index != n) {
    number++;
    if (checkIfTakuzu(number)) index++;
  }

  printf("%d\n", number);
  return 0;
}
