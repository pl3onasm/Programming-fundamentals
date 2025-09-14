/* file: prob5-1.c
   author: David De Potter
   version: 5.1, using a void function
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

void maximize(int *vec, int idx, int len, int sum, int *max){
  if (idx < 0){
    *max = sum > *max ? sum : *max;
    return;
  }
  // see if we can still add
  if (len < 2) maximize(vec, idx-1, len+1, sum + vec[idx], max);
  // skip
  maximize(vec, idx-1, 0, sum, max);  
}

int main(int argc, char **argv){
  int n, max = 0; 
  (void)! scanf("%d: ", &n);
  int *vec = readIntVector(n); 
  maximize(vec, n-1, 0, 0, &max); 
  printf("%d\n", max);
  free(vec);
  return 0; 
}