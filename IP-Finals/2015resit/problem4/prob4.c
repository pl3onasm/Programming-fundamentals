/* file: prob4.c
   author: David De Potter
   description: IP Final 2015 resit, problem 4, cycle detection
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int n, a[100];

  assert(scanf("%d", &n) == 1);

  for (int i = 0; i < n; ++i) 
    assert(scanf("%d", a + i) == 1);

  for (int i = 0; i < n; ++i) {
    if (a[i] == -1) continue;

    int j = i, len = 0;
    while (a[j] != -1) {
      int k = a[j];
      a[j] = -1;
      ++len;
      
      if (k == i) {  
          // cycle found, i is its smallest element
        printf("%d %d\n", i, len); 
        break;
      }
      j = k;
    }
  }

  return 0;
}