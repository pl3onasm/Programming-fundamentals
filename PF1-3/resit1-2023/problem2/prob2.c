/* file: prob2.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 2, Friday the 13th
*/

#include <stdio.h>
#include <stdlib.h>

int isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) 
          || year % 400 == 0;
}

int main(int argc, char *argv[]) {
  int year = 2023, count = 0, leapDays = 0;
  int totalDays, n;

  (void)! scanf ("%d", &n);

  /* A year has 365 days if not a leap year. 365-1 = 364
   * is divisible by 7 (number of days in a week), which
   * means we can count a day for each year and an extra
   * day for a leap year as we skip through the years */
  while (count != n) {
    year++;
    if (isLeapYear(year)) leapDays++;
    totalDays = year - 2023 + leapDays;
    if (totalDays % 7 == 0) count++;
    // if divisible by 7 we reached a point where Oct 13 
    // is a Friday again
  }

  // the nth next year starting from 2023 in which 
  // Oct 13 is a Friday
  printf("%d\n", year);
  return 0;
}