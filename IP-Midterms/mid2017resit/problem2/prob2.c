/* file: prob2.c
* author: David De Potter
* description: problem 2, Friday the 13th, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int isLeapYear(int year) {
  //determines whether the given year is a leap year
  return (year % 4 == 0 && year % 100 != 0) 
          || year % 400 == 0;
}

int main(int argc, char *argv[]) {
  int y=2017, n, count=0, currTotal, leapDays=0;

  //reads in the given number
  (void)! scanf("%d", &n);

  /* A year has 365 days if not a leap year. 365-1 = 364
   * is divisible by 7 (number of days in a week), which
   * means we can count a day for each year and an extra
   * day for a leap year as we skip through the years */
  while (count != n) {
    y++;
    if (isLeapYear(y)) leapDays++;
    currTotal = y - 2017 + leapDays;
    if (currTotal % 7 == 0) count++;
    //if divisible by 7 we know Oct 13 is a Friday again
  }
  //prints the nth next year in which Oct 13 is a Friday
  printf("%d\n", y);
  return 0;
}