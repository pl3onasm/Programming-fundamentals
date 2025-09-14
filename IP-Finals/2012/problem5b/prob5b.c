/* file: prob5b.c
   author: David De Potter
   description: IP Final 2012, problem 5b, 
   Recursive algorithms, reaching a number using
   dynamic programming
*/

#include <stdio.h>
#include <stdlib.h>

#include <stdio.h>
#include <stdlib.h>

void *safeCalloc (int n, int size) {
  /* allocates memory and checks if it was successful */
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%d, %d) failed. Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

int mReach (int a, int n, int *m) {
  if (a == n) return 1;
  if (a > n) return 0;
  if (! m[a]) 
    m[a] = mReach(a+1,n,m) + mReach(a+3,n,m) 
           + mReach (a*2,n,m);
  return m[a];
}

int reach (int a, int n){
  int *m = safeCalloc(n+1, sizeof(int));
  int res = mReach(a,n,m);
  free(m);
  return res;
}

int main(int argc, char *argv[]) {
  int a, n;
  (void)! scanf("%d %d", &a, &n);  
  printf("%d\n", reach(a, n));
  return 0;
}