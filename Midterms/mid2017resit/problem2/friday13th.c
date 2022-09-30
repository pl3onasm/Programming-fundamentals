/* file: friday13th.c
* author: David De Potter
* description: problem 2, Friday the 13th, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int isLeapYear(int year) {
  //determines whether the given year is a leap year
  if (year % 400 == 0) return 1;
  if (year % 100 == 0) return 0;
  if (year % 4 == 0) return 1;
  return 0;
}

int main(int argc, char *argv[]) {
  int y=2017, n, count=0, currTotal, leapYears=0;

  //reads in the given number
  scanf("%d", &n);

  /* A year has 365 days if not a leap year. 365-1 = 364
   * is divisible by 7 (number of days in a week), which
   * means we can count a day for each year and an extra
   * day for a leap year as we skip through the years */
  while (count != n) {
    y++;
    if (isLeapYear(y)) leapYears++;
    currTotal = y - 2017 + leapYears;
    if (currTotal % 7 == 0) count++;
    //if divisible by 7 we know Oct 13 is a Friday again
  }
  //prints the nth next year in which Oct 13 is a Friday
  printf("%d\n", y);
  return 0;
}