/* file: prob4.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 4, isograms
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
  int found = 0;
  char ch, word[200];
  
  // read each word and check for isogram
  while (scanf("%s", word) == 1) {
    int chars[26] = {0};    // histogram for characters in word
    int wLen = 0;
    for (int i = 0; i < strlen(word); i++) {
      ch = word[i];
      if (ch == '.') {
        word[wLen] = '\0';  // replace the dot with null char
        break;
      }
      if ('A' <= ch && ch <= 'Z') ch -= 'A' - 'a';
      if (ch < 'a' || ch > 'z' || chars[ch - 'a'] == 1) {
        wLen = 0;
        break;
      }
      chars[ch - 'a'] = 1;
      word[wLen++] = ch;
    } 
    if (wLen) {
      printf(found ? " %s" : "%s", word);
      found = 1;
    }
  }
  printf("\n");
  return 0;
}