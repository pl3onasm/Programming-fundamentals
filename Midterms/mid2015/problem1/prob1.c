/* file: prob1.c
* author: David De Potter
* description: problem1, multiples. mid2015
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int a, b, n, count=0;

  scanf("%d %d %d", &a, &b, &n);  
  for (int i=1; i<=n; ++i){   
    if ((i % a == 0) && (i % b == 0))
      count++;
  }
  printf("%d\n", count); 
  return 0;
}
