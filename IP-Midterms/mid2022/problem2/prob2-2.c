/* file: prob2-2.c
   author: David De Potter
   description: IP mid2022, problem 2, coalitions
     This version is a more compact version of prob2-1.c, 
     using bit manipulation
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================

int main() {
  int votes[3] = {0};   // votes for parties A, B, C
  int ch, total = 0, nCoalitions = 0;

  while ((ch = getchar()) != EOF && ch != '\n') {
    ++total;
    if      (ch == 'A') ++votes[0];
    else if (ch == 'B') ++votes[1];
    else                ++votes[2];
  }
    
    // iterate over all non-empty coalitions:
    // there are 2^3 - 1 = 7 non-empty subsets of {A,B,C},
    // represented by the integers 1..7 in binary form
  for (int mask = 1; mask < 8; ++mask) {     
    int sum = 0;
    int valid = 1;       // coalition is valid

      // check which parties are included in the coalition
    for (int p = 0; p < 3; ++p) {
      if (mask & (1 << p)) {
        // party p is included
        if (votes[p] == 0) { 
            // a party with zero votes cannot 
            // be in a winning coalition                
          valid = 0;
          break;
        }
        sum += votes[p];
      }
    }

      // check if coalition is winning
    if (valid && sum > total / 2)
      ++nCoalitions;
  }

  printf("%d\n", nCoalitions);
  return 0;
}
