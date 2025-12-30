/* file: prob6-1.c
   author: David De Potter
   description: extra, problem 6, balanced brackets
   Approach:
    We scan the input string from left to right and use a stack.
    Opening brackets '(', '[', '{' are pushed onto the stack.
    For each closing bracket ')', ']', '}', we pop the stack and
    check that the popped opening bracket matches the closing one.
    If we ever see a mismatch or a closing bracket when the stack
    is empty, the string is not balanced. At the end, the string 
    is balanced iff the stack is empty.
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================
// Allocates memory and checks if allocation was successful
void *safeCalloc (size_t n, size_t size) {
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    fprintf(stderr, "Error: calloc(%zu, %zu) failed.\n"
           "Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Reallocates memory and checks if reallocation was successful
void *safeRealloc (void *p, size_t n) {
  p = realloc(p, n);
  if (p == NULL) {
    fprintf(stderr, "Error: realloc(%zu) failed.\n"
                    "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return p;
}

//=================================================================
// Reads a line (up to '\n') and returns it as a dynamically 
// allocated char array (NOT null-terminated). 
// Stores its length in *len.
char *readString(size_t *len) {
  size_t capacity = 50, size = 0;
  char ch;

  char *s = safeCalloc(capacity, sizeof(char));

  while (scanf("%c", &ch) == 1 && ch != '\n') {
    if (size >= capacity) {
      capacity *= 2;
      s = safeRealloc(s, capacity * sizeof(char));
    }
    s[size++] = ch;
  }

  *len = size;
  return s;
}

//=================================================================
// Checks if the string of brackets is balanced using a stack
int isBalanced(char *s, size_t len) {
  char *stack = safeCalloc(len + 1, sizeof(char));
  int top = 0;
  for (size_t i = 0; i < len; i++) {
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
  size_t len;
  char *s = readString(&len);

  printf(isBalanced(s, len) ? "YES\n" : "NO\n");

  free(s);
  return 0;
}