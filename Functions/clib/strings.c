#include "clib.h"

  // checks whether a string is a palindrome;
  // start and end are pointers to the first and last
  // characters of the (sub)string we want to check
int isStrPalindrome(char *start, char *end) {
  while (start < end)
    if (*start++ != *end--) return 0;
  return 1;
}

  // case-insensitive comparison of strings s1 and s2
  // returns -1 if s1 < s2, 0 if s1 == s2, 1 if s1 > s2
int compareStrings(char *s1, char *s2) {
  int i = 0;
  while (s1[i] && s2[i]) {
    if (tolower(s1[i]) < tolower(s2[i])) return -1;
    if (tolower(s1[i]) > tolower(s2[i])) return 1;
    i++;
  }
  if (s1[i] && !s2[i]) return 1;
  if (!s1[i] && s2[i]) return -1;
  return 0;
}

  // returns a copy of string str, which must be 
  // freed by the caller
char *copyString(char *str) {
  CREATE_ARRAY(char, copy, strlen(str) + 1, 0);
  strcpy(copy, str);
  return copy;
}

  // reverses a given string str in place
void reverseString(char *str) {
  int len = strlen(str);
  for (int i = 0; i < len/2; i++)
    SWAP(str[i], str[len-i-1]);
}
