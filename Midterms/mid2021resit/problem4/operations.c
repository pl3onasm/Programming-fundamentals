/* file: operations.c
   author: David De Potter
   description: IP mid2021 resit, problem 4, operations
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

int *readArray (int n) {
  int *arr = safeMalloc(n * sizeof(int));
  for (int i = 0; i < n; i++) 
    scanf("%d,", &arr[i]);
  getchar(); 
  return arr;
}

void printArray (int *arr, int n) {
  for (int i = 0; i < n; i++) {
    printf("%d", arr[i]);
    if (i < n-1) printf(",");
  }
  printf("\n");
}

void swap (int *a, int *b) {
  int tmp = *a;
  *a = *b;
  *b = tmp;
}

int main(int argc, char *argv[]) {
  int size; 
  scanf("%d:", &size);
  int *arr = readArray(size);
  int a, b; char op[5]; 
  while (1) {
    scanf("%s ", op);
    switch (op[0]) {
    case 'M': 
      scanf("%d %d", &a, &b);
      arr[a] *= b;
      break;
    case 'T':
      printArray(arr, size); 
      return 0;
    case 'S':
      if (op[1] == 'U') {
        scanf("%d %d", &a, &b);
        arr[a] -= b;
      } else {
        scanf("%d %d", &a, &b);
        swap(&arr[a], &arr[b]);
      }
      break;
    }
  }
}