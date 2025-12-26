/* file: prob6-1.c
* author: David De Potter
* description: extra, problem 6, balanced brackets
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================
// Allocates memory and checks if allocation was successful
void *safeCalloc (size_t n, size_t size) {
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%zu, %zu) failed. " 
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
    printf("Error: realloc(%zu) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return p;
}

//=================================================================
// Reads a string of characters and determines its length
char *readString(size_t *len) {
  size_t capacity = 50, size = 0;
  char ch;
  char *s = safeCalloc(capacity, sizeof(char));
  while (scanf("%c", &ch) && ch != '\n' && ch != EOF) {
    if (size >= capacity) {
      capacity *= 2;
      s = safeRealloc(s, capacity * sizeof(char));
    }
    s[size++] = ch;
  }
  *len = size;
  s[size] = '\0'; // add null terminator
  return s;
}

//=================================================================
// Checks if the string of brackets is balanced using a stack
int isBalanced(char *s, size_t len) {
  char *stack = safeCalloc(len, sizeof(char));
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