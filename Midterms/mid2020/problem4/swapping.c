/* file: swapping.c
  author: David De Potter
  description: IP mid2020, problem 4, swapping letters
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(char *input, int x, int y) {
  char c;
  c = input[x];
  input[x] = input[y];
  input[y] = c;
}

int main(int argc, char *argv[]) {
  char input[27], command[5]; int x,y;
  char abc[27] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  scanf("%s", input);
  
  while (scanf("%s %d %d", command, &x, &y) != 1) 
    swap(input,x,y);
  if (!strcmp(input,abc)) printf("YES\n");
  else printf("NO\n");
  return 0;
}