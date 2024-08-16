#include "clib.h"

  // swaps two variables of any type
void swap(void *a, void *b, int size) {
  unsigned char *buffer = safeMalloc(size);
  memcpy(buffer, a, size);
  memcpy(a, b, size);
  memcpy(b, buffer, size);
  free(buffer);
}

  // allocates memory and checks whether this was successful
void *safeMalloc(int n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. "
           "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

  // allocates memory, initialized to 0, and
  // checks whether this was successful 
void *safeCalloc(int n, int size) {
  
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%d, %d) failed. "
           "Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

  // reallocates memory and checks if this was successful
void *safeRealloc(void *ptr, int newSize) {
  ptr = realloc(ptr, newSize);
  if (ptr == NULL) {
    printf("Error: realloc(%d) failed. " 
           "Out of memory?\n", newSize);
    exit(EXIT_FAILURE);
  }
  return ptr;
}
