#include "clib.h"

  // returns the number of digits in n
int countDigits(int n) {
  int count = 0;
  while (n) {
    n /= 10;
    count++;
  }
  return count;
}

  // returns the reverse of a given integer n
  // leading zeros are ignored, e.g. 1230 -> 321
  // Input of at most 9 digits long to avoid overflow
int reverseInt(int n) {
  int rev = 0;
  while (n) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

  // returns the left rotation of a given integer x,
  // ignoring leading zeros, e.g. 1234 -> 2341 
  // Input of at most 9 digits long to avoid overflow
int leftRotate(int x) {
  int pow = power(10, countDigits(x)-1);
  int firstDigit = x / pow;
  return (x % pow)*10 + firstDigit;
}

  // returns the right rotation of a given integer x,
  // ignoring leading zeros, e.g. 1234 -> 4123 
  // Input of at most 9 digits long to avoid overflow
int rightRotate(int x) {
  int pow = power(10, countDigits(x)-1);
  int lastDigit = x % 10;
  return lastDigit * pow + x / 10;
}

  // converts n to binary and stores the result in bin;
  // returns a pointer to the string bin, which must be
  // freed by the caller
char *toBinary(int n) {
  CREATE_ARRAY(char, bin, 33, 0);  // 32 bits + '\0'
  int len = 0;
  while (n > 0) {
    bin[len++] = n % 2 + '0';
    n >>= 1;
  }
  bin[len] = '\0';
  reverseString(bin);
  return bin; 
}

  // determines whether a given year is a leap year
int isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) 
          || year % 400 == 0;
}

  // returns a string representation of the given integer
  // the caller is responsible for freeing the memory
char *toString(int n) {
  CREATE_ARRAY(char, str, 11, 0);  // 10 digits + '\0'
  sprintf(str, "%d", n);
  return str;
}

  // checks whether given integer n is a palindrome
  // Note that we could use the reverseInt function
  // and check for equality. However, this may cause
  // overflow for large integers (of 10 digits)
int isIntPalindrome(int n) {
  char *str = toString(n);
  int ret = isStrPalindrome(str, str + strlen(str) - 1);
  free(str);
  return ret;
}
