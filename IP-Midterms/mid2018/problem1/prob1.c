/* file: prob1.c
   author: David De Potter
   description: problem 1, enclosed triangle, mid2018
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

//=================================================================

int main () {
  int x0, y0, x1, y1, x2, y2;
  int maxx, maxy, minx, miny;

    // read the coordinates of the rectangle
  assert(scanf("%d %d", &x0, &y0) == 2);
  assert(scanf("%d %d", &x1, &y1) == 2);

    // determine the rectangle's min x & y coordinates
  minx = MIN(x0, x1);
  miny = MIN(y0, y1);

    // determine the rectangle's max x & y coordinates
  maxx = MAX(x0, x1);
  maxy = MAX(y0, y1);

    // read the coordinates of the triangle
  assert(scanf("%d %d %d %d %d %d", 
                &x0, &y0, &x1, &y1, &x2, &y2) == 6);

    // if any of the min or max coords of the triangle exceed 
    // the bounds set by the rectangle's min and max coords, 
    // the triangle does not lie inside the rectangle
  if (MIN(MIN(x0, x1), x2) < minx || MIN(MIN(y0, y1), y2) < miny ||
      MAX(MAX(x0, x1), x2) > maxx || MAX(MAX(y0, y1), y2) > maxy) 
    printf("NO\n");
  else 
    printf("YES\n");

  return 0;
}
