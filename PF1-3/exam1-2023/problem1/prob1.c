/* file: prob1.c
   author: David De Potter
   description: PF 1/3rd term 2023, problem 1, cigarette butts
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int butts, cigarettes = 0, total = 0;
  assert(scanf("%d", &butts) == 1);
    
    // Each iteration:
    // - exchange 4 butts for 1 cigarette
    // - smoke those cigarettes (each yields 1 new butt)
    // - keep leftover butts (butts % 4) for the next round
  while (butts >= 4) { 
    cigarettes = butts / 4;         
    total += cigarettes;            
    butts = cigarettes + butts % 4; 
  }

  printf("%d\n", total);

  return 0;
}