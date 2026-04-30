/* file: stableford.c
   author: David De Potter
   description: problem 5, Stableford, mid2017
*/

#include <stdio.h>
#include <assert.h>

//=================================================================

int main() {
  int par, index, handicap, strokes, score = 0;

  assert(scanf("%d", &handicap) == 1);

  for (int hole = 0; hole < 18; ++hole) {

    assert(scanf("%d %d %d", &par, &index, &strokes) == 3);
    
      // compute personal par, which is the normal par
      // plus extra strokes according to handicap
    par += handicap / 18 + (index <= handicap % 18 ? 1 : 0);
    
      // compute score for the hole
    if (strokes < par + 2) 
      score += 2 + par - strokes;
  }

  printf("%d\n", score);

  return 0;
}
