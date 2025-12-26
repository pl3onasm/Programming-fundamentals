/* 
  file: prob7-2.c
  author: David De Potter
  description: extra, problem 7, matching bitstrings
  version: 7.2, using the clib library
*/

#include "../../Functions/include/clib/clib.h"

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
  char *bits; size_t n;

  assert(scanf("%zu ", &n) == 1);
  
  C_NEW_ARRAY(char, bits, n + 1);

  C_READ_ARRAY(bits, "%c", n);

  getBitstrings(bits, 0, n, 0, 0);

  free(bits);
  
  return 0;
}