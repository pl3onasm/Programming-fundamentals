/* file: prob2.c
   author: David De Potter
   description: problem2, squaring digits, mid2015
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int n, count = 0, sum, digit, number;

  assert(scanf("%d", &n) == 1);

  for (int i = 1; i <= n; ++i) {
    number = i;
    while (number != 1 && number != 89) {
      sum = 0;
      while (number != 0) {
        digit = number % 10;
        sum += digit * digit;
        number /= 10;
      }
      number = sum;
    }

    if (number == 89)
      ++count;
  }

  printf("%d\n", count);
  return 0;
}