/* file: prob4.c
  author: David De Potter
  description: IP mid2021, problem 4, difference triangles
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
// Reads len integers from standard input into array arr
void readInput(int *arr, int len) {
  for (int i = 0; i < len; ++i)
    assert(scanf("%d", &arr[i]) == 1);
}

//=================================================================
// Prints the array of given length
void printArray (int *arr, int len){
  for (int i = 0; i < len; ++i) {
    printf("%d", arr[i]);
    if (i < len - 1) printf(" "); 
  }
  printf("\n");
}

//=================================================================
// Returns the absolute difference between a and b
int absDiff (int a, int b) {
  return (a < b) ? (b - a) : (a - b);
}

//=================================================================
// Computes the difference array of given length
void computeDiffArray (int *arr, int len) {
  for (int i = 0; i < len - 1; ++i) 
    arr[i] = absDiff(arr[i], arr[i + 1]);
}

//=================================================================

int main() {
  int n, *a;
  
  assert(scanf("%d", &n) == 1);
  a = safeMalloc(n * sizeof(int));
  readInput(a, n); 
  
  for (int i = n; i > 0; --i){
    printArray(a, i); 
    computeDiffArray(a, i); 
  }

  free(a);

  return 0;
}