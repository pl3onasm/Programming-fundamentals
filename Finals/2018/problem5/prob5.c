#include <stdio.h>
#include <stdlib.h>

int isMatch(char *pattern, char *string) {
  // base cases
  if (*string == '\0' && *pattern == '\0') return 1;  
  if (*string == '\0' || *pattern == '\0') return 0;  
  // recursive cases
  if (pattern[1] == '?')
    return (*pattern == *string && isMatch(pattern+2, string+1)) 
            || isMatch(pattern+2, string);
  return (*pattern == *string && isMatch(pattern+1, string+1));
}

int main(int argc, char *argv[]) {
  char pattern[30], string[30];
  scanf("%s %s", pattern, string);
  if (isMatch(pattern, string) == 0) {
    printf("NO ");
  }
  printf("MATCH\n");
  return 0;
}
