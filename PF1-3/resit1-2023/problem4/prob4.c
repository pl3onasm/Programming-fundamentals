/* file: prob4.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 4, isograms
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================
// Checks whether ch is a letter (A-Z or a-z)
static int isLetter(int ch) {
  return ('A' <= ch && ch <= 'Z') || ('a' <= ch && ch <= 'z');
}

//=================================================================
// Converts uppercase letter to lowercase. 
// Leaves other chars unchanged
static int toLower(int ch) {
  if ('A' <= ch && ch <= 'Z')
    return ch + ('a' - 'A');
  return ch;
}

//=================================================================

int main() {
  int found = 0;        // flags whether any isogram was found
  int seen[26] = {0};   // letters seen in current word
  char word[201];       // max 200 letters + '\0'
  int len = 0;          // current word length
  int isogram = 1;      // current word is still an isogram
  int ch;               // current character

  while ((ch = getchar()) != EOF) {
    if (isLetter(ch)) {
      ch = toLower(ch);

        // start of a new word
      if (len == 0) {
        for (int i = 0; i < 26; ++i)
          seen[i] = 0;
        isogram = 1;
      }

        // check if letter was already seen in current word
      if (seen[ch - 'a'])
        isogram = 0;

        // mark letter as seen and add to current word
      seen[ch - 'a'] = 1;
      word[len++] = (char)ch;
    
    } else {
        // print current word if it is an isogram
      if (len > 0 && isogram) {
        word[len] = '\0';
        printf(found ? " %s" : "%s", word);
        found = 1;
      }
        // stop if full stop encountered
      if (ch == '.')
        break;
        // reset current word
      len = 0;                      
    }
  }

  printf("\n");
  return 0;
}
