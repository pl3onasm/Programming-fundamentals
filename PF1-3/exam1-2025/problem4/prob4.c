/* file: prob4.c
   author: David De Potter
   description: PF 1/3rd term 2025, problem 4, 
                palindromic rotation
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

//===================================================================
// checks if the string delimited by start and end is a palindrome
// returns 1 if it is, 0 otherwise
int isStrPalindrome(char *start, char *end) {
  while (start < end)
    if (*start++ != *end--) return 0;
  return 1;
}

//===================================================================
// performs a cyclic left rotation of the string str of length len
void rotate(char* str, int len) {
  char first = str[0];
  for (int i = 0; i < len - 1; i++) 
    str[i] = str[i + 1];
  
  str[len - 1] = first;  
}

//===================================================================

int main() {
  char word[21] = {0};
  assert(scanf("%s", word) == 1);
  int len = strlen(word);

    // check all cyclic rotations of the string
  for (int i = 0; i < len; i++) {
    if (isStrPalindrome(word, word + len - 1)) {
      printf("%s\n", word);
      return 0;
    }
      // not a palindrome, rotate and check again
    rotate(word, len);
  }

    // no palindromic rotation found
  printf("###\n");

  return 0;
}