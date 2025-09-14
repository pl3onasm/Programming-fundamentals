/* file: prob4.c
* author: David De Potter
* description: problem 4, digital spiral sum, mid2015
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int m, n, sum=0;
  (void)! scanf("%d %d", &n, &m);
  
  for (int i = 0; i<n; ++i){
    m += i*2;
    sum += m;
  }
  
  printf("%d\n", sum);

  return 0;
}
