/* file: prob5.c
   author: David De Potter
   description: IP mid2019 resit, problem 5, McCarthy Function
   
   We print the computation trace of McCarthy's function f(n):

     if n > 100 then f(n) = n - 10
     else            f(n) = f(f(n + 11))

   Idea of this iterative simulation:
   countf tracks how many pending applications of f(..) are still
   "around" the current value n in the expression we print.
   Each loop iteration performs one rewrite step and prints the
   new expression form.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int n, countf = 1;

  assert(scanf("%d", &n) == 1);
  printf("f(%d)", n);

  while (countf > 0) {

    if (n > 100) {
        // A call f(n) resolves to n-10, removing one f(..)
      --countf;
      n -= 10;
      printf("=");
      for (int i = 1; i <= countf; ++i) printf("f(");
      printf("%d", n);
      for (int i = 1; i <= countf; ++i) printf(")");

    } else {
        // A call f(n) expands to f(f(n+11)), adding one f(..)
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
