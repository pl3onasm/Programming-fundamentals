/* file: stableford.c
* author: David De Potter
* description: problem 5, Stableford, mid2017
*/

#include <stdio.h>

int main(int argc, char *argv[]) {
  int par, index, handicap, strokes, score = 0;

  (void)! scanf("%d", &handicap);

  for (int hole=0; hole<18; hole++) {
    (void)! scanf("%d %d %d", &par, &index, &strokes);
    par += handicap/18 + (index <= handicap%18);
    /* personal par is the normal par + 1 or 2 strokes
     * depending on the index */

    if (strokes < par + 2) {
      /* no points are awarded if 2 or more strokes than
       * the personal par were needed */
      score += 2 + par - strokes;
    }  
  }

  printf("%d\n", score);
  return 0;
}
