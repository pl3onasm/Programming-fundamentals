/* file: prob1.c
  author: David De Potter
  description: IP mid2021, problem 1, comparing fractions
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int a, b, c, d;
  char op;

  assert(scanf("%d/%d%c%d/%d", &a, &b, &op, &c, &d) == 5);

  if((op == '<' && a*d < b*c) || (op == '>' && a*d > b*c)) 
    printf("YES\n");
  else 
    printf("NO\n");

  return 0;
}