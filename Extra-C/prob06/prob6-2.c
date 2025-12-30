/* 
  file: prob6-2.c
  author: David De Potter
  description: extra, problem 6, balanced brackets
  version: 6.2, using the clib library
*/

#include "../../Functions/include/clib/clib.h"

//=================================================================
// Checks if the string of brackets is balanced using a stack
int isBalanced(char *s, size_t len) {
  char *stack; int top = 0;
  C_NEW_ARRAY(char, stack, len + 1);
  
  for (size_t i = 0; i < len; ++i) {
    if (s[i] == '(' || s[i] == '[' || s[i] == '{') {
      stack[top++] = s[i];
      continue;
    } 
    if (--top < 0 
      || (s[i] == ')' && stack[top] != '(') 
      || (s[i] == ']' && stack[top] != '[') 
      || (s[i] == '}' && stack[top] != '{')) {
        free(stack);
        return 0;
      }
  }
  free(stack);
  return top == 0;  
}

//=================================================================

int main () {
 
  char *str; 
  size_t len;
  C_READ_LINE(str, len);
  
  printf(isBalanced(str, len) ? "YES\n" : "NO\n");

  free(str);
  return 0;
}