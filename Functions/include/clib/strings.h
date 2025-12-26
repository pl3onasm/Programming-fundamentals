#ifndef CLIB_STRINGS_H_INCLUDED
#define CLIB_STRINGS_H_INCLUDED

int   c_isStrPalindrome(const char *start, const char *end);
int   c_strcmpCI(const char *s1, const char *s2);
char *c_copyString(const char *s);
void  c_reverseString(char *s);

#endif 
