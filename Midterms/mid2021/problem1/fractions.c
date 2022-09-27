/* file: fractions.c
  author: David De Potter
  description: IP mid2021, problem 1, comparing factors
*/

#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
  int a, b, c, d;
  char op;

  scanf("%d/%d%c%d/%d", &a, &b, &op, &c, &d);

  if((op == '<' && a*d < b*c) || (op == '>' && a*d > b*c)) printf("YES\n");
  else printf("NO\n");

  return 0;
}