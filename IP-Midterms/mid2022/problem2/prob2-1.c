/* file: prob2-1.c
   author: David De Potter
   description: IP mid2022, problem 2, coalitions
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
    
  int coalitions[7][3] = {
    {1, 0, 0},   // A
    {0, 1, 0},   // B
    {0, 0, 1},   // C
    {1, 1, 0},   // AB
    {1, 0, 1},   // AC
    {0, 1, 1},   // BC
    {1, 1, 1}    // ABC
  };
    
    // iterate over all non-empty coalitions
  for (int i = 0; i < 7; ++i) {
    int sum   = 0;
    int valid = 1;       // coalition is valid 

    for (int p = 0; p < 3; ++p) {
      if (coalitions[i][p]) {
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
