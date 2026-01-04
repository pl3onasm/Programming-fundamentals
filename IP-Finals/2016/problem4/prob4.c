/* file: prob4.c
   author: David De Potter
   description: IP Final 2016, problem 4, highest common ancestor
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int a, b;
  int parent[] = {0,1,1,0,3,1,3,1,4,5,8,5,8,5,11,11,13,13,16,16};
  
  assert(scanf("%d %d", &a, &b) == 2);
  
  while (a != b) {
    if (a == parent[a] && b == parent[b]) {
      printf("NONE\n");
      return 0; 
    }
    if (a > b) 
      a = parent[a];
    else 
      b = parent[b];
  }

  printf("%d\n", a);
  
  return 0;
}