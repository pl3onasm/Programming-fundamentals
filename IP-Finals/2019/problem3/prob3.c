/* file: prob3.c
   author: David De Potter
   description: IP Final 2019, problem 3, 
   Towers of Hanoi
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Moves a disc from rod 'from' to rod 'to'
// Returns 1 if the move was illegal, 0 otherwise
int putDisc(int n, int from, int to, int i, int rods[][10]){
  int disc = 0, j, k, flag = 0; 

    // find the top disc on rod 'from'
  for (j = 0; j < n; ++j)
    if (rods[from][j]){
      disc = rods[from][j];
      rods[from][j] = 0;
      break;
    }

    // place the disc on rod 'to'
  for (k = 0; k < n; ++k){
    if (rods[to][k]){
      rods[to][k - 1] = disc;
      if (rods[to][k] < disc)
          // wrong disc order: larger disc on top of smaller
        flag = 1;
      break;
    }
    if (k == n - 1) 
        // reached bottom of rod: place disc here
      rods[to][k] = disc;
  }

  if (flag || j == n) {     
      // if j == n, no disc was found to move from source rod
    printf("ILLEGAL MOVE %d\n", i + 1);
    return 1;
  }
  return 0; 
}

//=================================================================

int main(){
  int n, m, rods[3][10] = {0}, from, to;
  assert(scanf("%d %d", &n, &m) == 2);

  for (int i = 0; i < n; ++i)
    rods[0][i] = i + 1;

  for (int i = 0; i < m; ++i) {
    assert(scanf("%d->%d", &from, &to) == 2);
    int illegal = putDisc(n, from, to, i, rods);
    if (illegal) return 0; 
  } 

  if (rods[1][0] == 1 || rods[2][0] == 1) 
    printf("SOLVED\n"); 
  else printf("UNSOLVED\n");

  return 0; 
}