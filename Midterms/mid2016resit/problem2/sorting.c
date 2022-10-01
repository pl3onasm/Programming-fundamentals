/* file: sorting.c
* author: David De Potter
* description: problem 2, sorting numbers, resit mid2016
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int numbers[100] = {0}, n, lastNumber=0;
  scanf("%d ", &n);
  while (n != 0) {
    numbers[n]++;
    scanf("%d ", &n);
    lastNumber++;
  }
  int count = 0;
  for (int i=99; i > 0; --i) {
    if (numbers[i] != 0) {
      for (int j=0; j < numbers[i]; ++j) {
        count++;
        if (count < lastNumber) printf("%d,", i);
        else printf("%d\n", i);
      }
    }
  }
  return 0;
}
