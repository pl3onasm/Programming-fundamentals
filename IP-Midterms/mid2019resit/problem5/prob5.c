/* file: prob5.c
* author: David De Potter
* description: IP mid2019 resit, problem 5,
* McCarthy Function
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n, countf = 1;

  (void)! scanf("%d", &n);
  printf("f(%d)", n);

  while (countf > 0) {

    if (n > 100) {
      --countf;
      n -= 10;
      printf("=");
      for (int i = 1; i <= countf; ++i) printf("f(");
      printf("%d", n);
      for (int i = 1; i <= countf; ++i) printf(")");

    } else {
      ++countf;
      n += 11;
      printf("=");
      for (int i = 1; i <= countf; ++i) printf("f(");
      printf("%d", n);
      for (int i = 1; i <= countf; ++i) printf(")");
    }
  }

  printf("\n");
  return 0;
}
