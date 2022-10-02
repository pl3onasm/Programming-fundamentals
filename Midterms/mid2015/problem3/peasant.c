/* file: peasant.c
* author: David De Potter
* description: problem 3, peasant multiplication, mid2015
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int x, y, sum=0;
  scanf("%d %d", &x, &y);  
  printf("%d*%d=", x, y);

  if ((x != 0) && (y != 0)) {
    while (y != 0) {
      if (y % 2 != 0) {
        if (sum == 0) printf("%d", x);
        else printf("+%d", x);
        sum += x;
      }
      x *= 2;
      y /= 2;
    }
    printf("=%d\n", sum); 
  } else printf("%d\n", sum);
  return 0;
}
