/* file: prob4.c
  author: David De Potter
  description: IP mid2020 resit, problem 4, ancestor
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Reads parent-child relationships from standard input
// and fills the parent array accordingly
void readInput(int *parent, int n) {
  int x, y;
  while (scanf(" father(%d)=%d", &x, &y) == 2)
    parent[x] = y;
}

//=================================================================
// Initializes the parent array to -1 (no parent)
void initializeArray(int *parent, int n) {
  for (int i = 0; i < n; ++i) 
    parent[i] = -1; 
}

//=================================================================
// Checks if anc is an ancestor of desc using the parent array
int isAncestor(int *parent, int n, int anc, int desc) {
  if (anc < 0 || anc >= n || desc < 0 || desc >= n)
    return 0;
  if (anc == desc)
    return 0;  

  for (int cur = parent[desc]; cur != -1; cur = parent[cur])
    if (cur == anc)
      return 1;
  
  return 0;
}


//=================================================================

int main() {
  int n, anc, desc, parent[1000];
  assert(scanf("%d", &n) == 1);

  initializeArray(parent, n);
  readInput(parent, n);

  assert(scanf(" ancestor(%d,%d)", &anc, &desc) == 2);

  printf(isAncestor(parent, n, anc, desc) ? "YES\n" : "NO\n");
  
  return 0;
}