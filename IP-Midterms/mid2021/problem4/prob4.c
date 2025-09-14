/* file: prob4.c
  author: David De Potter
  description: IP mid2021, problem 4, difference triangles
*/

#include <stdio.h>
#include <stdlib.h>

void *safeMalloc(int sz) {
  void *p = calloc(sz, 1);
  if (p == NULL) {
    fprintf(stderr, "Fatal error: safeMalloc(%d) failed.\n", sz);
    exit(EXIT_FAILURE);
  }
  return p;
}

int *makeIntArray(int n) {
  return safeMalloc(n*sizeof(int));
}

void readInput(int *arr, int len) {
  for (int i=0; i<len; i++)
    (void)! scanf("%d ", &arr[i]);
}

void printArray (int *arr, int len){
  for (int i=0; i<len; i++){
    printf("%d",arr[i]);
    if (i<len-1) printf(" "); 
  }
  printf("\n");
}

int absDiff (int a, int b) {
  if (a-b < 0) return b-a;
  return a-b;
}

void computeDiffArray (int *arr, int len) {
  for (int i=0; i<len-1; ++i) 
    arr[i] = absDiff(arr[i],arr[i+1]);
}

int main(int argc, char *argv[]) {
  int n, *a;
  
  (void)! scanf("%d", &n);
  a = makeIntArray(n);
  readInput(a,n); 
  
  for (int i=n; i>0; --i){
    printArray(a,i); 
    computeDiffArray(a,i); 
  }
  free(a);
  return 0;
}