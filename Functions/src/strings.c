#include <ctype.h>
#include <string.h>

#include "clib/clib.h"

//=================================================================
// Checks if a string is a palindrome
int c_isStrPalindrome(const char *start, const char *end) {
  while (start < end) 
    if (*start++ != *end--) return 0;  
  return 1;
}

//=================================================================
// Case-insensitive string comparison
int c_strcmpCI(const char *s1, const char *s2) {
  size_t i = 0;  
  while (s1[i] && s2[i]) {    
    unsigned char c1 = s1[i];    
    unsigned char c2 = s2[i]; 
    int t1 = tolower(c1);    
    int t2 = tolower(c2);    
    if (t1 < t2) return -1;    
    if (t1 > t2) return  1;    
    ++i;  
  }  
  if (s1[i] && !s2[i]) return  1;  
  if (!s1[i] && s2[i]) return -1;  
  return 0;
}

//=================================================================
// Creates a copy of a string. The caller is responsible for 
// freeing the memory.
char *c_copyString(const char *s) {
  size_t len = strlen(s);  
  char *copy = (char *)c_safeMalloc(len + 1);  
  memcpy(copy, s, len + 1);  
  return copy;
}

//=================================================================
// Reverses a string in place
void c_reverseString(char *s) {
  size_t len = strlen(s);  
  for (size_t i = 0; i < len / 2; ++i) 
    C_SWAP(s[i], s[len - 1 - i]);
}