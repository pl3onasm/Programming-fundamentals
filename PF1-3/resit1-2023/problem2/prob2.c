/* file: prob2.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 2, Friday the 13th
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks whether year is a leap year
int isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) 
          || year % 400 == 0;
}

//=================================================================

int main() {
  int year = 2023, count = 0;
  int shift = 0, n;

  assert(scanf ("%d", &n) == 1);

  /* Since 364 is a multiple of 7, the weekday of Oct 13 shifts by:
   * - +1 for a normal year (365 % 7 == 1)
   * - +2 for a leap year (366 % 7 == 2)
   *
   * Therefore, compared to Oct 13, 2023 (a Friday), Oct 13 of a 
   * later year is again a Friday exactly when the total shift in 
   * weekdays is a multiple of 7.
   */
  while (count != n) {
    ++year;
    shift += 1 + isLeapYear(year); 
    if (shift % 7 == 0) ++count;
  }

    // the nth next year starting from 2023 in which 
    // Oct 13 is a Friday
  printf("%d\n", year);

  return 0;
}