/* file: prob5-1.c
   author: David De Potter
   version: 5.1, first computing all subsequences, then
      checking if they are palindromes, and taking max length
   description: IP Final 2021, problem 5, longest palindromic sequence
*/

#include <stdio.h>
#include <stdlib.h>

void *safeCalloc (int n, int size) {
  /* allocates memory and checks if it was successful */
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%d, %d) failed. Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

char *createString(int size){
  return safeCalloc(size, sizeof(char));
}

int isPalindrome (int start, int end, char *s) {
  if (start >= end) return 1;
  if (s[start] != s[end]) return 0;
  return isPalindrome(start+1, end-1, s);
}

int getMaxPal (char *s, char *seq, int n, int idx, int subLen) {
  int x = 0, y = 0;
  if (idx >= n) {
    if (isPalindrome(0, subLen-1, seq)) return subLen;
    return 0;
  }
  if (subLen < n) {    // take char at index idx from s
    seq[subLen] = s[idx];    
    x = getMaxPal(s, seq, n, idx+1, subLen+1);
  }
  // skip current char from s
  y = getMaxPal(s, seq, n, idx+1, subLen);

  return x > y ? x : y;
}

int main(int argc, char **argv){
  int n; 
  (void)! scanf("%d", &n);
  char *s = createString(n+1);
  char *seq = createString(n);
  (void)! scanf("%s", s);
  printf("%d\n", getMaxPal(s, seq, n, 0, 0));
  free(s); free(seq);
  return 0; 
}
