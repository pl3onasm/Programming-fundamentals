/* file: prob1.c
   author: David De Potter
   description: problem 1, happy New Year, mid2013
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// checks whether a year is a leap year
int isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) 
          || year % 400 == 0;
}

//=================================================================

int main() {
  int year, total = 0;
  char const * weekdays[7] = {"Tuesday","Wednesday","Thursday",
                              "Friday","Saturday","Sunday",
                              "Monday"};

  assert(scanf("%d", &year) == 1);
  
  /* A year has 365 days if not a leap year. 
   * Since 364 is a multiple of 7, the weekday of 
   * Jan 1 shifts by one day for a normal year, 
   * and by two days for a leap year.
   *
   * We know Jan 1, 1901 was a Tuesday. We count 
   * the total weekday shift from 1901 to the 
   * given year, and use that to determine the 
   * weekday of Jan 1 of the given year.
   */
  for (int y = 1901; y < year; ++y) 
    total += 1 + isLeapYear(y);
  
  printf("%s\n", weekdays[total % 7]);
  return 0;
}

