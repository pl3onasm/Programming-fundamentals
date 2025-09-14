/* file: prob3.c
* author: David De Potter
* description: problem 3, ABC, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  char prefixes[100];
  int len=0, counta, countb, countc;
  char c;
  //reads the input string and computes its length
  while ((c = getchar()) != '.') {
    prefixes[len] = c;
    ++len;
  }

  /* goes through the different prefixes one by one and
   * checks whether they comply with the rules */
  for (int prefixLen=0; prefixLen <= len-1; ++prefixLen) {
    counta = countb = countc = 0;
    for (int j=0; j <= prefixLen; ++j) {
      if (prefixes[j] == 'a') counta++;
      if (prefixes[j] == 'b') countb++;
      if (prefixes[j] == 'c') countc++;
    }
    if ((countb > counta) || (countc > counta + countb)) {
      /* at least one of the prefixes does not comply,
       * so the input string is invalid */
      printf("INVALID\n");
      return 0;
    }
  }

  printf("VALID\n");
  return 0;
}
