/* file: prob5-2.c
   author: David De Potter
   version: 5.2, without using isPalindrome. This is faster,
      because we don't have all the extra work at the base case
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

int getMaxPal (char *s, int start, int end) {
  if (start >= end) 
    return start == end;
  if (s[start] == s[end])                // take both 
    return 2 + getMaxPal(s, start+1, end-1);  
  int x = getMaxPal(s, start+1, end);    // skip start
  int y = getMaxPal(s, start, end-1);    // skip end
  return x > y ? x : y;
}

int main(int argc, char **argv){
  int n; 
  (void)! scanf("%d", &n);
  char *s = createString(n+1);
  (void)! scanf("%s", s);
  printf("%d\n", getMaxPal(s, 0, n-1));
  free(s); 
  return 0; 
}
