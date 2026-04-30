/* file: prob5.c
   author: David De Potter
   description: IP mid2021 resit, problem 5, Vigenere cipher
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates n bytes of memory, exits if allocation fails
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    fprintf(stderr, "Error: malloc(%zu) failed. "
                    "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================

int main() {
  int msgLen, keyLen, j = 0;
  assert(scanf("%d %d", &msgLen, &keyLen) == 2);
  
  char *word = safeMalloc((msgLen + 1) * sizeof(char));
  char *key  = safeMalloc((keyLen + 1) * sizeof(char));
  
  assert(scanf("%s", word) == 1);
  assert(scanf("%s", key)  == 1);
  
  for (int i = 0; i < msgLen; ++i) {
    int c = word[i]  - 'A';
    int k = key[j++] - 'A';
    printf("%c", (c + k) % 26 + 'A');
    if (j == keyLen) j = 0;
  }
  
  printf("\n");
  free (word); 
  free (key);

  return 0;
}