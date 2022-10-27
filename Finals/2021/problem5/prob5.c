/* file: prob5.c
   author: David De Potter
   description: IP Final 2021, problem 5, longest palindromic sequence
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void *safeMalloc (int n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

char *createString(int size){
  char *string = safeMalloc(size * sizeof(char));
  return string;
}

int isPalindrome(char *s, int index) {
  if (index >= strlen(s) / 2) return 1;
  if (s[index] != s[strlen(s) - index - 1]) return 0;
  return isPalindrome(s, index + 1);
}

void checkSequences (char *s, char *seq, int si, int seqi, int *max) {
  if (si > strlen(s)) return;
  if (isPalindrome(seq, 0) && seqi > *max) *max = seqi;
  seq[seqi] = s[si];  // take char at index si from s
  seq[seqi + 1] = '\0';
  checkSequences(s, seq, si+1, seqi+1, max);
  seq[seqi] = '\0';   // don't take current char from s
  checkSequences(s, seq, si+1, seqi, max);
}

int main(int argc, char **argv){
  int n, max=0; 
  scanf("%d", &n);
  char *s = createString(n+1);
  char *seq = createString(n+1);
  scanf("%s", s);
  checkSequences(s, seq, 0, 0, &max);
  printf("%d\n", max);
  free(s); free(seq);
  return 0; 
}
