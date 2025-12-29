/* 
  file: prob11.c
  author: David De Potter
  description: extra, problem 11, anagrams for palindromes
  time complexity:  O(n)
  space complexity: O(1)
*/

#include "../../Functions/include/clib/clib.h"
#include <string.h>

//=================================================================
// Builds histogram of character frequencies from standard input
// considering only alphabetic characters and ignoring case
char *getHistogram() {
  char *hist, ch;
  C_NEW_ARRAY(char, hist, 26);

  while ((ch = getchar()) != EOF && ch != '\n') {
    if (ch >= 'a' && ch <= 'z') 
      hist[ch - 'a']++;
    else if (ch >= 'A' && ch <= 'Z') 
      hist[ch - 'A']++;
  }
  return hist;
}

//=================================================================
// Checks if a palindrome can be formed from the histogram by
// ensuring at most one character has an odd frequency
int containsPalin(char *hist) {
  size_t oddCount = 0;

  for (size_t i = 0; i < 26; ++i) {
    if (hist[i] % 2 != 0) 
      oddCount++;
    if (oddCount > 1) 
      return 0;
  }
  return 1;
}

//=================================================================

int main() {
  char *hist = getHistogram();

  containsPalin(hist) ? printf("YES\n") 
                      : printf("NO\n");   

  free(hist);

  return 0;
}