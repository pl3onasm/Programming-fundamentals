/* file: equation.c
   author: David De Potter
   description: problem 2, equation, mid2017
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int a, b;
  char op;

  if (scanf("%d", &a) == 1) {
      // equation has the form (3) - (6)
    assert(scanf(" %c", &op) == 1);

    if (scanf("%d", &b) == 1)
      // equation has the form (5) or (6)
      printf("x=%d\n", (op == '+' ? a + b : a - b));

    else {
      // equation has the form (3) or (4)
      assert(scanf("x=%d", &b) == 1);
      printf("x=%d\n", (op == '+' ? b - a : a - b));
    }

  } else {
      // equation has the form (1) or (2)
    assert(scanf("x%c%d=%d", &op, &a, &b) == 3);
    printf("x=%d\n", (op == '+' ? b - a : b + a));
  }

  return 0;
}
