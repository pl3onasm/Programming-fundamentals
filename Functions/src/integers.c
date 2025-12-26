#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "clib/clib.h"

//=================================================================
int c_countDigits(int n) {
  if (n == 0) 
    return 1;  
  int count = 0;  
  if (n < 0) 
    n = -n;  
  while (n > 0) {    
    n /= 10;    
    ++count;  
  }  
  return count;
}

//=================================================================
int c_reverseInt(int n) {
  int rev = 0;  
  while (n) {    
    rev = rev * 10 + (n % 10);    
    n /= 10; 
  }  
  return rev;
}

//=================================================================
int c_leftRotate(int n) {
  int digits = c_countDigits(n);
  if (digits <= 1) 
    return n;  
  int pow10 = c_power(10, digits - 1);  
  int first = n / pow10;  
  return (n % pow10) * 10 + first;
}

//=================================================================
int c_rightRotate(int n) {
  int digits = c_countDigits(n);
  if (digits <= 1) 
    return n;  
  int pow10 = c_power(10, digits - 1);  
  int last = n % 10;  
  return last * pow10 + n / 10;
}

//=================================================================
char *c_toBinary(int n) {
    if (n == 0) {    
      char *s = c_safeMalloc(2);    
      s[0] = '0'; 
      s[1] = '\0';    
      return s;  
    }  
  char buf[33];  // enough for 32-bit int plus terminator
  size_t len = 0;  
  while (n > 0 && len < sizeof(buf) - 1) {    
    buf[len++] = '0' + (n & 1);    
    n >>= 1;  
  }  
  buf[len] = '\0';  
    // reverse the string  
  char *out = c_safeMalloc(len + 1);  
  memcpy(out, buf, len + 1);  
  c_reverseString(out);  
  return out;
}

//=================================================================
// Checks if a year, given as an integer, is a leap year
int c_isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) 
          || (year % 400 == 0);
}

//=================================================================
// Converts an integer to a string. The caller is responsible for 
// freeing the memory.
char *c_toString(int n) {
  char buf[16];  // enough for 32-bit int
  snprintf(buf, sizeof(buf), "%d", n);  
  size_t len = strlen(buf);  
  char *out = c_safeMalloc(len + 1);  
  memcpy(out, buf, len + 1); 
   return out;
}

//=================================================================
// Checks if an integer is a palindrome
int c_isIntPalindrome(int n) {
  char *s = c_toString(n); 
  int ok = c_isStrPalindrome(s, s + strlen(s) - 1);  
  free(s);  
  return ok;
}