/* file: prob5.c
  author: David De Potter
  description: IP mid2021, problem 5, matching pairs
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
// Counts the number of matching pairs (a,b) such that f[a] = b 
// and g[b] = a
int countPairs (int *f, int n, int *g, int m) {
  int b, count = 0; 
  for (int a = 0; a < n; ++a) {
    b = f[a]; 
    if (0 <= b && b < m && g[b] == a)
      ++count;
  }
  return count; 
}

//=================================================================

int main() {
  int *f, n, *g, m;
  
  assert(scanf("%d:", &n) == 1);
  f = safeMalloc(n * sizeof(int));
  readInput(f, n); 

  assert(scanf("%d:", &m) == 1);
  g = safeMalloc(m * sizeof(int));
  readInput(g, m); 
  
  printf("%d\n", n < m ? countPairs(f, n, g, m) 
                       : countPairs(g, m, f, n));

  free(f); 
  free(g);

  return 0;
}