/* file: equation.c
* author: David De Potter
* description: problem 2, equation, mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int a, b;
  char operator;

  if (scanf("%d", &a) == 1) {
    // equation has the form (3) - (6)
    (void)! scanf("%c", &operator);
    if (scanf("%d", &b) == 1)
      // equation has the form (5) or (6)
      printf("x=%d\n", (operator == '+' ? a+b : a-b));
    else {
      // equation has the form (3) or (4)
      (void)! scanf("x=%d", &b);
      printf("x=%d\n", (operator == '+' ? b-a : a-b));
    }
  } else {
    // equation has the form (1) or (2)
    (void)! scanf("x%c%d=%d", &operator, &a, &b);
    printf("x=%d\n", (operator == '+' ? b-a : b+a));
  }
  return 0;
}
