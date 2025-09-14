/* file: prob5-2.c
   author: David De Potter
   version: 5.2, using an int function
   description: IP Final 2020, problem 5, choice maximization
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

int *readIntVector(int size) {
  int i, *vec = safeMalloc(size*sizeof(int));
  for (i=0; i < size; i++) (void)! scanf("%d", &vec[i]);
  return vec;
}

int maximize(int *vec, int idx, int len){
  int x = 0, y = 0; 
  if (idx < 0) return 0;
  // see if we can still add
  if (len < 2) x = vec[idx] + maximize(vec, idx-1, len+1);
  // skip
  y = maximize(vec, idx-1, 0);
  return x > y ? x : y;  
}

int main(int argc, char **argv){
  int n; 
  (void)! scanf("%d: ", &n);
  int *vec = readIntVector(n); 
  printf("%d\n", maximize(vec, n-1, 0));
  free(vec);
  return 0; 
}
