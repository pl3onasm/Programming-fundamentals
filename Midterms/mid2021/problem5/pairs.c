/* file: pairs.c
  author: David De Potter
  description: IP mid2021, problem 5, matching pairs
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
    scanf("%d ", &arr[i]);
}

int countPairs (int *f, int n, int *g, int m) {
  int a, count = 0; 
  for (int i=0; i<n; i++) {
    a = f[i]; 
    if (a < m && g[a] == i) count++; 
  }
  return count; 
}

int main(int argc, char *argv[]) {
  int *f, *g, m, n;
  
  scanf("%d:", &n);
  f = makeIntArray(n);
  readInput(f,n); 

  scanf("%d:", &m);
  g = makeIntArray(m);
  readInput(g,m); 
  
  if (m > n) printf("%d\n", countPairs(g,m,f,n));
  else printf("%d\n", countPairs(f,n,g,m));

  free(f); free(g);
  return 0;
}