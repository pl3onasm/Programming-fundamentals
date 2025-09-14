/* file: prob3.c
* author: David De Potter
* description: problem 3, peasant multiplication, mid2015
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int x, y, sum=0;
  (void)! scanf("%d %d", &x, &y);  
  printf("%d*%d=", x, y);

  if (x && y) {
    while (y) {
      if (y % 2) {
        printf(sum ? "+%d" : "%d", x);
        sum += x;
      }
      x *= 2;
      y /= 2;
    }
    printf("=%d\n", sum); 
  } else printf("%d\n", sum);
  
  return 0;
}
