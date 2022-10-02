/* file: triangle.c
* author: David De Potter
* description: problem 1, enclosed triangle, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int max (int x, int y) {
  return (x > y ? x : y);
}

int min (int x, int y) {
  return (x < y ? x : y);
}

int main (int argc, char *argv[]) {
  int x0, y0, x1, y1, x2, y2;
  int maxx, maxy, minx, miny;

  //reads the coordinates of the rectangle
  scanf("%d %d", &x0, &y0);
  scanf("%d %d", &x1, &y1);
  //determines the rectangle's min x & y coordinates
  minx = min(x0, x1);
  miny = min(y0, y1);
  //determines the rectangle's max x & y coordinates
  maxx = max(x0, x1);
  maxy = max(y0, y1);

  //reads the coordinates of the triangle
  scanf("%d %d\n%d %d\n%d %d", &x0, &y0, &x1, &y1, &x2, &y2);
  /* if any of the min or max coordinates of the triangle exceed the
  * boundaries set by the rectangle's min and max coordinates, the
  * triangle does not lie inside the rectangle */
  if ((min(min(x0, x1), x2) < minx) || ((min(min(y0, y1), y2) < miny)) ||
      (max(max(x0, x1), x2) > maxx) || (max(max(y0, y1), y2) > maxy)) {
    printf("NO\n");
  } else printf("YES\n");
  return 0;
}
