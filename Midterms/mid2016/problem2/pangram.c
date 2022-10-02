/* file: pangram.c
* author: David De Potter
* description: problem 2, pangram, mid2016
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int index, sum=0, letterFreq[26];
  char c;

  /* the array letterFreq has a cell for each letter of the
   * alphabet. For every character that lies between A-Z, the
   * corresponding cell index is assigned the number 1 */
  while ((c = getchar()) != '.') {
    if ((c >= 'A') && (c <= 'Z')) {
      index = c - 'A';
      letterFreq[index] = 1;
    }
  }
  /* if the sum of all the array's cells equals 26, then
   * every letter of the alphabet occurred at least once */
  for (int i=0; i <= 25; i++)
    sum += letterFreq[i];

  if (sum == 26) printf("PANGRAM\n");
  else printf("NO PANGRAM\n");

  return 0;
}
