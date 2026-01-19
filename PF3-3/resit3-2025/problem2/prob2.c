/* 
  file: prob2.c
  author: David De Potter
  description: 3-3rd resit 2025, problem 2,
    clockwise string rotation
  time complexity: O(n^2)
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

//===================================================================
// Rotates a given string by one position to the left.
// E.g. "hello" becomes "elloh".
void rotateLeft(char* str, int len) {

  char first = str[0];

    // Shift all characters to the left by one position
  for (int i = 0; i < len - 1; ++i) 
    str[i] = str[i + 1];

    // Put the original first character at the end
  str[len - 1] = first; 
}

//===================================================================

int main() {
  char str1[1001], str2[1001];

  assert(scanf("%1000s %1000s", str1, str2) == 2);

  int len1 = strlen(str1);
  int len2 = strlen(str2);

  if (len1 != len2) {
    printf("NO\n");
    return 0;
  }

  for (int i = 0; i < len1; ++i) {
    if (strcmp(str1, str2) == 0) {
      printf("YES\n");
      return 0;
    }
    rotateLeft(str1, len1);
  }

  printf("NO\n");
  return 0;
}