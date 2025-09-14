/* file: prob4.c
  author: David De Potter
  description: IP mid2020 resit, problem 4, ancestor
*/

#include <stdio.h>
#include <stdlib.h>

void *safeMalloc (int n) {
  void *p = malloc(n);
  if (p == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return p;
}

int *makeIntArray(int n) {
  /* allocates int array of size n */
  return safeMalloc(n * sizeof(int));
}

void readInput(int *f, int n) {
  int x, y;
  while (scanf("father(%d)=%d\n", &x, &y)) 
    f[x] = y;
}

void initializeArray(int *f, int n) {
  for (int i=0; i<n; i++) f[i] = -1; 
}

int isAncestor(int *f, int n, int anc, int desc) {
  while (1) {
    if (desc < 0 || desc >= n) return 0;
    if (f[desc] == anc) return 1;
    desc = f[desc];
  }
}

int main(int argc, char *argv[]) {
  int n, *f, anc, desc;
  
  (void)! scanf("%d\n", &n); 

  f = makeIntArray(n);
  initializeArray(f,n);
  readInput(f,n);

  (void)! scanf("ancestor(%d,%d)\n", &anc, &desc);

  printf(isAncestor(f, n, anc, desc) ? "YES\n" : "NO\n");
  
  free(f);
  return 0;
}