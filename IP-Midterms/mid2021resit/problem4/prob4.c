/* file: prob4.c
   author: David De Potter
   description: IP mid2021 resit, problem 4, operations
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
// Reads an array of n integers from standard input
int *readArray (int n) {
  int *arr = safeMalloc(n * sizeof(int));
  for (int i = 0; i < n; i++) 
    assert(scanf("%d%*[,\n]", &arr[i]) == 1);
  return arr;
}

//=================================================================
// Prints an array of n integers to standard output
void printArray (int *arr, int n) {
  for (int i = 0; i < n; ++i) {
    printf("%d", arr[i]);
    if (i < n - 1) printf(",");
  }
  printf("\n");
}

//=================================================================
// Swaps the values of two integers
void swap (int *a, int *b) {
  int tmp = *a;
  *a = *b;
  *b = tmp;
}

//=================================================================

int main() {
  int size; 
  assert(scanf("%d:", &size) == 1);
  int *arr = readArray(size);
  int a, b; char op[5]; 
  while (1) {
    assert(scanf("%4s", op) == 1);
    switch (op[0]) {
    case 'M': 
      assert(scanf("%d %d", &a, &b) == 2);
      arr[a] *= b;
      break;
    case 'T':
      printArray(arr, size); 
      free(arr);
      return 0;
    case 'S':
      if (op[1] == 'U') {
        assert(scanf("%d %d", &a, &b) == 2);
        arr[a] -= b;
      } else {
        assert(scanf("%d %d", &a, &b) == 2);
        swap(&arr[a], &arr[b]);
      }
      break;
    }
  }
}