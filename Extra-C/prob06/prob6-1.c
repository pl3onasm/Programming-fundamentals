/* file: prob6-1.c
* author: David De Potter
* description: extra, problem 6, balanced brackets
*/

#include <stdio.h>
#include <stdlib.h>

void *safeCalloc (int n, int size) {
  /* allocates memory and checks if it was successful */
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%d, %d) failed. Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

void *safeRealloc (void *p, int n) {
  // checks if memory has been reallocated successfully
  p = realloc(p, n);
  if (p == NULL) {
    printf("Error: realloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return p;
}

char *readString(int *len) {
  // reads a string of characters and determines its length
  int capacity = 50, size = 0;
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

int isBalanced(char *s, int len) {
  char *stack = safeCalloc(len, sizeof(char));
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


int main (int argc, char *argv[]) {
  int len;
  char *s = readString(&len);

  printf(isBalanced(s, len) ? "YES\n" : "NO\n");

  free(s);
  return 0;
}