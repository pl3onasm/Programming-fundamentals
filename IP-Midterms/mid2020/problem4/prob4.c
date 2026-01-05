/* file: prob4.c
  author: David De Potter
  description: IP mid2020, problem 4, swapping letters
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

//=================================================================
// Swaps the characters pointed to by a and b
void swap(char *a, char *b) {
  char temp = *a;
  *a = *b;
  *b = temp;
}

//=================================================================

int main() {
  char input[27], command[5]; 
  int x, y;
  char abc[27] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  
  assert(scanf("%26s", input) == 1);
  
  while (scanf("%4s", command) == 1) {
    if (! strcmp(command, "stop"))
      break;

    assert(! strcmp(command, "swap"));
    assert(scanf("%d %d", &x, &y) == 2);

    swap(&input[x], &input[y]);
  }

  printf(! strcmp(input,abc) ? "YES\n" : "NO\n");

  return 0;
}