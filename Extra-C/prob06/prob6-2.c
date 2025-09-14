/* 
  file: prob6-2.c
  author: David De Potter
  description: extra, problem 6, balanced brackets
  version: 6.2, using the clib library
*/

#include "../../Functions/clib/clib.h"

int isBalanced(char *s, int len) {
  CREATE_ARRAY(char, stack, len, 0);
  int top = 0;
  for (int i = 0; i < len; i++) {
    if (s[i] == '(' || s[i] == '[' || s[i] == '{') {
      stack[top++] = s[i];
      continue;
    } 
    --top;
    if (top < 0 
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


int main () {
 
  READ_STR_UNTIL(str, '\n', len);
  
  printf(isBalanced(str, len) ? "YES\n" : "NO\n");

  free(str);
  return 0;
}