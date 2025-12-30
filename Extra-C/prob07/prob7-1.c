/* 
  file: prob7-1.c
  author: David De Potter
  description: extra, problem 7, matching bitstrings
  Approach:
    The input string contains fixed bits ('0'/'1') and wildcards 
    ('?'). We fill the wildcards using recursion (backtracking) 
    from left to right, ensuring we never place three equal bits 
    in a row.

    While constructing the string, we keep track of the current run
    length of consecutive 0s (count0) or consecutive 1s (count1) 
    ending at the previous position. When we place a 0 we increase 
    count0 and reset count1 to 0 (and vice versa). A choice is only 
    allowed if its run length would not exceed 2.

    To output solutions in lexicographical (binary) order, we 
    always try '0' before '1' when we encounter a '?'.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h> 

//=================================================================
// Allocates memory and checks if successful
void *safeMalloc (size_t n) {
  void *p = malloc(n);
  if (p == NULL) {
    printf("Error: malloc(%zu) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return p;
}

//=================================================================
// Reads a string of n bits
char *readString (size_t n) {
  char *bits = safeMalloc((n + 1) * sizeof(char));
  assert(scanf("%1000s", bits) == 1);
  return bits;
}

//=================================================================
// Prints, in lexicographical order, all bitstrings of length n 
// with no more than 2 consecutive 0s or 1s
void getBitstrings (char *bits, size_t idx, size_t n, 
                    size_t count0, size_t count1) {
  
    // base case
  if (idx == n) {
    printf("%s\n", bits);
    return;
  }

    // recursive case
  switch (bits[idx]) {
    case '?':
      bits[idx] = '0';
      if (count0 < 2) getBitstrings(bits, idx+1, n, count0+1, 0);
      bits[idx] = '1';
      if (count1 < 2) getBitstrings(bits, idx+1, n, 0, count1+1);
      bits[idx] = '?';    // backtrack
      break;
    case '0':
      if (count0 < 2) getBitstrings(bits, idx+1, n, count0+1, 0);
      break;
    case '1':
      if (count1 < 2) getBitstrings(bits, idx+1, n, 0, count1+1);
      break;
  }
}

//=================================================================

int main () {
  size_t n;

  assert(scanf("%zu", &n) == 1);

  char *bits = readString(n);

  assert(strlen(bits) == n);

  getBitstrings(bits, 0, n, 0, 0);

  free(bits);
  
  return 0;
}