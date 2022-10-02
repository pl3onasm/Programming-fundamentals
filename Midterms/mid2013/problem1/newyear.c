/* file: newyear.c
* author: David De Potter
* description: problem 1, happy New Year, mid2013
*/

#include <stdio.h>
#include <stdlib.h>


int isLeapYear(int year) {
  //determines if year is a leap year
  if (year % 400 == 0) return 1;
  if (year % 100 ==0) return 0;
  if (year % 4 == 0) return 1;
  return 0;
}

int main(int argc, char *argv[]) {
  int year, leapyears=0, total;
  char* weekdays[7] = {"Tuesday","Wednesday","Thursday",
                       "Friday","Saturday","Sunday","Monday"};

  scanf("%d", &year);
  /* A year has 365 days if not a leap year. 365-1 = 364
   * is divisible by 7 (number of days in a week), which
   * means we can count a day for each year and an extra
   * day for a leap year as we skip through the years */
  for (int y = 1901; y < year; ++y) {
    if (isLeapYear(y)) leapyears++;
  }
  total = year - 1901 + leapyears;
  printf("%s\n", weekdays[total % 7]);
  return 0;
}
