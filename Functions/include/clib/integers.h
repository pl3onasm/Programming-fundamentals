/* integers.h - integer utilities */

#ifndef CLIB_INTEGERS_H_INCLUDED
#define CLIB_INTEGERS_H_INCLUDED

int   c_countDigits(int n);
int   c_reverseInt(int n);
int   c_leftRotate(int n);
int   c_rightRotate(int n);

char *c_toBinary(int n);     /* caller frees */
int   c_isLeapYear(int year);
char *c_toString(int n);     /* caller frees */
int   c_isIntPalindrome(int n);

#endif 
