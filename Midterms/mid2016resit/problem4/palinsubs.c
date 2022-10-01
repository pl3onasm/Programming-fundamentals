/* file: palinsubs.c
* author: David De Potter
* description: problem 4, palindromic sentences, resit mid2016.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int readInput(char sentence[]) {
  char c; int i = 0;
  while ((c = getchar()) != '.')
    if (c != ' ') sentence[i++] = c;
  return --i;
}

int isPalindrome (int start, int end, char sentence[]) {
  if (start >= end) return 1;
  if (sentence[start] != sentence[end]) return 0;
  return isPalindrome(start+1, end-1, sentence);
} 

int main (int argc, char *argv[]) {
  char sentence[100]; int max=0, start; 
  int len = readInput(sentence);
  for (int l=len; l > 0; --l) {
    for (int i = 0; i <= l; ++i) {
      if (isPalindrome(i, l, sentence)) {
        if (l-i > max) {
          max = l-i; start = i;
        }
      }
    }
  }
  for (int i = start; i <= start+max; ++i) 
    printf("%c", sentence[i]);
  printf("\n");
  return 0;
}
