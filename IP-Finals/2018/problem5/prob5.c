/* file: prob5.c
   author: David De Potter
   description: IP Final 2018, problem 5, pattern matching
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks whether the pattern matches the source string
int isMatch(char *pattern, char *src) {
    
    // base case: pattern finished
  if (*pattern == '\0')
    return *src == '\0';

    // optional character match
  if (pattern[1] == '?')
      // either skip the '?' and preceding character or
      // match the preceding character once
    return (*pattern == *src && isMatch(pattern + 2, src + 1)) 
            || isMatch(pattern + 2, src);
    
    // normal character match 
  return (*pattern == *src && isMatch(pattern + 1, src + 1));
}

//=================================================================

int main() {
  char pattern[30], src[30];
  assert(scanf("%s %s", pattern, src) == 2);

  printf("%s\n", isMatch(pattern, src) ? "MATCH" : "NO MATCH");

  return 0;
}
