/* file: prob1.c
   author: David De Potter
   description: PF 1/3rd term 2023, problem 1, cigarette butts
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int butts, cigarettes = 0, total = 0;
  (void)! scanf("%d", &butts);
  
  while (butts >= 4) { 
    cigarettes = butts / 4;         // 4 butts make 1 cigarette
    total += cigarettes;            // add cigarettes to total
    butts = cigarettes + butts % 4; // remaining butts after smoking
  }

  printf("%d\n", total);

  return 0;
}