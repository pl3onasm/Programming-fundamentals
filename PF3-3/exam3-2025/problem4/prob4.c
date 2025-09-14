/* 
  file: prob4.c
  author: David De Potter
  description: PF 3/3rd term 2025, problem 4, 
                Interleaving arrays
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Allocates memory for n bytes, exits if malloc fails
void *safeMalloc (int n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//===================================================================
// Reads the input from stdin and returns an array of integers
int *readInput(int *size) {
  assert(scanf("%d:", size) == 1);
  int *arr = safeMalloc(*size * sizeof(int));
  for (int i = 0; i < *size; i++) 
    assert(scanf("%d", &arr[i]) == 1);
  return arr;
}

//===================================================================
// Checks if the array C is an interleaving of A and B
void checkInterleaving(int *arrA, int sizeA, int *arrB, 
                       int sizeB, int *arrC, int sizeC) {
  int i = 0, j = 0, k = 0;
  while (k < sizeC) {
    if (i < sizeA && j < sizeB 
        && arrA[i] == arrB[j] 
        && arrA[i] == arrC[k]) 
      i < j ? i++ : j++;
    else if (i < sizeA && arrA[i] == arrC[k]) i++;
    else if (j < sizeB && arrB[j] == arrC[k]) j++;
    else {
      printf("NO\n");
      return;
    }
    k++;
  }
  printf("YES\n");
}

//===================================================================

int main() {
  int sizeA, sizeB, sizeC;
  int *arrA = readInput(&sizeA);
  int *arrB = readInput(&sizeB);
  int *arrC = readInput(&sizeC);

  if (sizeA + sizeB != sizeC) 
    printf("NO\n");
  else checkInterleaving(arrA, sizeA, arrB, sizeB, arrC, sizeC);

  free(arrA);
  free(arrB);
  free(arrC);
  
  return 0;
}