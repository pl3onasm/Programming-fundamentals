/* file: prob1.c
  author: David De Potter
  description: IP mid2020 resit, problem 1, Nine's complement
  This simplified version uses string manipulation instead of 
  integer arithmetic
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  char s[32];   
  assert(scanf("%31s", s) == 1);

  for (int i = 0; s[i] != '\0'; ++i) {
    int digit = s[i] - '0';
    s[i] = '0' + (9 - digit);
  }

  printf("%s\n", s);
  return 0;
}

