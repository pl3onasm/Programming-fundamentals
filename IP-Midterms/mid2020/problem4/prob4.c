/* file: prob4.c
  author: David De Potter
  description: IP mid2020, problem 4, swapping letters
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(char *a, char *b) {
  char temp = *a;
  *a = *b;
  *b = temp;
}

int main(int argc, char *argv[]) {
  char input[27], command[5]; int x,y;
  char abc[27] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  
  (void)! scanf("%s", input);
  
  while (scanf("%s %d %d", command, &x, &y) != 1) 
    swap(&input[x], &input[y]);

  printf(!strcmp(input,abc) ? "YES\n" : "NO\n");

  return 0;
}