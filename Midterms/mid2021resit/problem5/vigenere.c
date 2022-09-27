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
  char *arr = safeMalloc(n * sizeof(char));
  return arr;
}

void expandKey (char *key, int keyLen, int msgLen) {
  int i = 0;
  while (keyLen < msgLen) {
    key[keyLen++] = key[i++];
    if (i == keyLen) i = 0;
  }
}

int main(int argc, char *argv[]) {
  int msgLen, keyLen;
  scanf("%d %d:", &msgLen, &keyLen);
  char *word = createArray(msgLen);
  char *key = createArray(msgLen);
  scanf("%s %s", word, key);
  if (keyLen < msgLen) expandKey(key, keyLen, msgLen); 
  for (int i = 0; i < msgLen; i++) {
    int c = word[i] - 'A';
    int k = key[i] - 'A';
    printf("%c", (c + k) % 26 + 'A');
  }
  printf("\n");
  return 0;
}