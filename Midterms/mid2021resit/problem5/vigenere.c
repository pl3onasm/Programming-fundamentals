/* file: vigenere.c
   author: David De Potter
   description: IP mid2021 resit, problem 5, Vigenere cipher
*/

#include <stdio.h>
#include <stdlib.h>

void *safeMalloc (int n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

char *createArray (int n) {
  char *arr = safeMalloc((n+1) * sizeof(char));
  return arr;
}

int main(int argc, char *argv[]) {
  int msgLen, keyLen, j=0;
  scanf("%d %d:", &msgLen, &keyLen);
  
  char *word = createArray(msgLen);
  char *key = createArray(keyLen);
  
  scanf("%s", word);
  scanf("%s", key);
  
  for (int i = 0; i < msgLen; i++) {
    int c = word[i] - 'A';
    int k = key[j++] - 'A';
    printf("%c", (c + k) % 26 + 'A');
    if (j == keyLen) j = 0;
  }
  printf("\n");
  return 0;
}