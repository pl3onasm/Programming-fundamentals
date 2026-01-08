/* 
  file: prob11.c
  author: David De Potter
  description: extra, problem 11, anagrams for palindromes
  time complexity:  O(n)
  space complexity: O(1)

  Approach:
    A string can be rearranged into a palindrome iff at most one
    character occurs an odd number of times. All other characters
    must occur an even number of times so they can be mirrored 
    around the center of the palindrome.
    
    That is why we build a small histogram of letter frequencies 
    while reading the input, mapping both uppercase and lowercase 
    letters to the same 26 bins. Afterwards, we count how many bins 
    have an odd frequency. If more than one letter has an odd 
    count, we output NO. Otherwise we output YES.
*/

#include "../../Functions/include/clib/clib.h"
#include <string.h>

//=================================================================
// Builds histogram of character frequencies from standard input
// considering only alphabetic characters and ignoring case
int *getHistogram() {
  int *hist, ch;
  C_NEW_ARRAY(int, hist, 26);

  while ((ch = getchar()) != EOF && ch != '\n') 
    if (ch >= 'a' && ch <= 'z') 
      ++hist[ch - 'a'];
    else if (ch >= 'A' && ch <= 'Z') 
      ++hist[ch - 'A'];
  
  return hist;
}

//=================================================================
// Checks if a palindrome can be formed from the histogram by
// ensuring at most one character has an odd frequency
int containsPalin(int *hist) {
  size_t oddCount = 0;

  for (size_t i = 0; i < 26; ++i) {
    if (hist[i] % 2) 
      ++oddCount;
    if (oddCount > 1) 
      return 0;
  }
  return 1;
}

//=================================================================

int main() {
  int *hist = getHistogram();

  printf(containsPalin(hist) ? "YES\n" : "NO\n");

  free(hist);

  return 0;
}