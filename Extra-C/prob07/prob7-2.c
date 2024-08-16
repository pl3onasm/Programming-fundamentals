/* 
  file: prob7-2.c
  author: David De Potter
  description: extra, problem 7, matching bitstrings
  version: 7.2, using the clib library
*/

#include "../../Functions/clib/clib.h"

void getBitstrings (char *bits, int idx, int n, int count0, int count1) {
  // prints, in lexicographical order, all bitstrings of length n 
  // with no more than 2 consecutive 0s or 1s

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

int main (int argc, char *argv[]) {
  int n;

  (void)! scanf("%d ", &n);

  CREATE_ARRAY(char, bits, n + 1, 0);

  READ_ARRAY(bits, "%c", n);

  getBitstrings(bits, 0, n, 0, 0);

  free(bits);
  
  return 0;
}