/* file: prob5.c
   author: David De Potter
   description: PF 1/3rd term 2024, problem 5,
                cycle detection
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory, initialized to 0, and
// checks whether this was successful 
void *safeCalloc(size_t n, size_t size) {
  
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%lu, %zu) failed. "
           "Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//===================================================================
// Reads the input from stdin and stores it in an array
int *readInput(int n) {
  int *arr = safeCalloc(n, sizeof(int));
  for (int i = 0; i < n; i++)
    assert(scanf("%d", &arr[i]) == 1);
  return arr;
}

//===================================================================
// Detects a cycle in the array
void detectCycle(int *arr, int n) {
  
  int *visited = safeCalloc(n, sizeof(int));
  int idx = 0, i = 1;
  visited[idx] = i;

  while (1) {
    if (visited[arr[idx]]) {
      printf("%d %d\n", arr[idx], i - visited[arr[idx]] + 1);
      break;
    }
    visited[arr[idx]] = ++i;
    idx = arr[idx];
  }
  free(visited);
}

//===================================================================

int main() {
  int n;
  assert(scanf("%d", &n) == 1);

  int *arr = readInput(n);

  detectCycle(arr, n); 

  free(arr);

  return 0;
}