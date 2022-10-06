/* file: prob4.c
   author: David De Potter
   description: IP Final 2015 resit, problem 4, cycle detection
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n, a[100];
  scanf("%d", &n);
  for (int i = 0; i < n; i++) 
    scanf("%d", a + i);
  for (int i = 0; i < n; i++) {
    int j = i, count=0; 
    while (a[j] != -1) {
      count++; 
      int k = a[j];
      a[j] = -1;
      if (a[k] == -1) printf("%d %d\n", k, count); 
      j = k;
    }
  }
  return 0;
}