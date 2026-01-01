/* file: prob2.c
   author: David De Potter
   description: PF 1/3rd term 2024, problem 2, animal day
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// checks whether a year is a leap year
int isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) 
          || year % 400 == 0;
}

//===================================================================

int main() {
  int year = 2024, count = 0, n, shift = 0;
  assert(scanf("%d", &n) == 1);

  /* Since 364 is a multiple of 7, the weekday of Oct 4 shifts by:
   * - +1 for a normal year (365 % 7 == 1)
   * - +2 for a leap year (366 % 7 == 2)
   *
   * We know Oct 4, 2024 is a Friday. We keep track of the total 
   * weekday shift since 2024: one day per year passed, plus one 
   * extra day for each leap year we pass. Whenever the total shift 
   * is a multiple of 7, Oct 4 is a Friday again.
   */
  while (count != n) {
    ++year;
    shift += 1 + isLeapYear(year); 
    if (shift % 7 == 0) ++count;
  }

  printf("%d\n", year);

  return 0;
}