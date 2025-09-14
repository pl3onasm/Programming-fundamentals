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
  int n;
  assert(scanf("%d", &n) == 1);

  // A year has 365 days if not a leap year. 365-1 = 364
  // is divisible by 7 (number of days in a week), which
  // means we can count a day for each year and an extra
  // day for a leap year as we skip through the years 
  int year = 2024, count = 0, leapDays = 0;
  while (count < n) {
    year++;
    if (isLeapYear(year)) leapDays++;
    int totalDays = year - 2024 + leapDays;
    if (totalDays % 7 == 0) count++;
      // if divisible by 7, Animal Day is on a Friday again
  }

  printf("%d\n", year);

  return 0;
}