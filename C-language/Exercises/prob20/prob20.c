/* 
  file: prob20.c
  author: David De Potter
  description: grid points on a disk

  Approach:
    A grid point (x, y) lies inside or on the disk iff:

      x^2 + y^2 <= r^2
    
    We focus on the first quadrant, where x and y are non-negative.
    The number of grid points in the other three quadrants follows
    from symmetry.

    We iterate over x from 0 to r and maintain the largest integer 
    y such that (x, y) still lies inside the disk. As x increases,
    this maximal y can never increase, so over the whole algorithm
    y decreases at most r times. This allows us to determine the
    number of valid points for each x in O(1) amortized time, 
    instead of O(r) time if we were to check all y values for 
    each x, which would yield an O(r^2) algorithm.

    The number of grid points for a given x is then:
      - if x = 0, we count the y-axis points
      - if x > 0, symmetry gives both the left and right half, and
        for positive y also the reflected points below the x-axis

    This yields an O(r) algorithm.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Counts the number of integer grid points contained within a disk 
// with radius r and center (0, 0).
size_t countGridPoints(size_t r) {
  size_t count = 0;
  size_t rr = r * r;
  size_t y = r;

  for (size_t x = 0; x <= r; ++x) {
    while (x * x + y * y > rr)
      --y;

    if (x == 0)
      count += 1 + 2 * y;
    else
      count += 2 + 4 * y;
  }

  return count;
}

//=================================================================

int main() {
  size_t r;
  assert(scanf("%zu", &r) == 1);

  printf("%zu\n", countGridPoints(r));
  return 0;
}