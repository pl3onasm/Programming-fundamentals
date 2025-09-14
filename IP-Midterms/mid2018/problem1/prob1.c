/* file: prob1.c
* author: David De Potter
* description: problem 1, enclosed triangle, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((b) > (a) ? (a) : (b))

int main (int argc, char *argv[]) {
  int x0, y0, x1, y1, x2, y2;
  int maxx, maxy, minx, miny;

  //reads the coordinates of the rectangle
  (void)! scanf("%d %d", &x0, &y0);
  (void)! scanf("%d %d", &x1, &y1);
  //determines the rectangle's min x & y coordinates
  minx = MIN(x0, x1);
  miny = MIN(y0, y1);
  //determines the rectangle's max x & y coordinates
  maxx = MAX(x0, x1);
  maxy = MAX(y0, y1);

  //reads the coordinates of the triangle
  (void)! scanf("%d %d\n%d %d\n%d %d", &x0, &y0, &x1, &y1, &x2, &y2);
  /* if any of the min or max coordinates of the triangle exceed the
  * boundaries set by the rectangle's min and max coordinates, the
  * triangle does not lie inside the rectangle */
  if (MIN(MIN(x0, x1), x2) < minx || MIN(MIN(y0, y1), y2) < miny ||
      MAX(MAX(x0, x1), x2) > maxx || MAX(MAX(y0, y1), y2) > maxy) {
    printf("NO\n");
  } else printf("YES\n");
  return 0;
}
