/* file: prob2.c
   author: David De Potter
   description: problem 2, pangram, mid2016
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================

int main() {
  int ch, index, sum = 0, letterFreq[26] = {0};

  /* the array letterFreq has a cell for each letter of the
   * alphabet. For every character that lies between A-Z, the
   * corresponding cell index is assigned the number 1 
   */
  while ((ch = getchar()) != '.') {
    if ((ch >= 'A') && (ch <= 'Z')) {
      index = ch - 'A';
      letterFreq[index] = 1;
    }
  }
    // if the sum of all array cells equals 26, then
    // every letter of the alphabet occurred at least once
  for (int i = 0; i < 26; ++i)
    sum += letterFreq[i];

  printf(sum == 26 ? "PANGRAM\n" 
                   : "NO PANGRAM\n");

  return 0;
}
