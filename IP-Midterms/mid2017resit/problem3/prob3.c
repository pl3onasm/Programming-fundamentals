/* file: prob3.c
   author: David De Potter
   description: problem 3, ABC, resit mid2017
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================

int main() {
  int counta = 0, countb = 0, countc = 0;
  int valid = 1;
  int ch;

  while ((ch = getchar()) != EOF && ch != '.') {
    if      (ch == 'a') ++counta;
    else if (ch == 'b') ++countb;
    else if (ch == 'c') ++countc;
    else continue;   // ignore unexpected characters

    if (countb > counta || countc > counta + countb)
      valid = 0;
  }

  printf(valid ? "VALID\n" : "INVALID\n");
  
  return 0;
}
