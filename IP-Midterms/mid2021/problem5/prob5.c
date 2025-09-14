/* file: prob5.c
  author: David De Potter
  description: IP mid2021, problem 5, matching pairs
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
  return safeMalloc(n*sizeof(int));
}

void readInput(int *arr, int len) {
  for (int i=0; i<len; i++)
    (void)! scanf("%d ", &arr[i]);
}

int countPairs (int *f, int n, int *g, int m) {
  int b, count = 0; 
  for (int a = 0; a < n; ++a) {
    b = f[a]; 
    count += b < m && g[b] == a; 
  }
  return count; 
}

int main(int argc, char *argv[]) {
  int *f, n, *g, m;
  
  (void)! scanf("%d:", &n);
  f = makeIntArray(n);
  readInput(f,n); 

  (void)! scanf("%d:", &m);
  g = makeIntArray(m);
  readInput(g,m); 
  
  printf("%d\n", n < m ? countPairs(f,n,g,m) : countPairs(g,m,f,n));

  free(f); free(g);
  return 0;
}