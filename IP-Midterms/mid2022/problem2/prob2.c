/* file: prob2.c
   author: David De Potter
   description: IP mid2022, problem 2, coalitions
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================

int main() {
  int votes[3] = {0, 0, 0};   // votes for parties A, B, C
  int ch;

  while ((ch = getchar()) != EOF && ch != '\n') {
    if      (ch == 'A') ++votes[0];
    else if (ch == 'B') ++votes[1];
    else if (ch == 'C') ++votes[2];
  }

  int total = votes[0] + votes[1] + votes[2];
  int half  = total / 2;
  int coalitions = 0;
    
    // iterate over all non-empty coalitions:
    // there are 2^3 - 1 = 7 non-empty subsets of {A,B,C},
    // represented by the integers 1..7 in binary form
  for (int mask = 1; mask < 8; ++mask) {     
    int sum = 0;
    int ok = 1;       // coalition is valid

      // check which parties are included in the coalition
    for (int p = 0; p < 3; ++p) {
      if (mask & (1 << p)) {
        // party p is included
        if (votes[p] == 0) { 
            // a party with zero votes cannot 
            // be in a winning coalition                
          ok = 0;
          break;
        }
        sum += votes[p];
      }
    }

      // check if coalition is winning
    if (ok && sum > half)
      ++coalitions;
  }

  printf("%d\n", coalitions);
  return 0;
}
