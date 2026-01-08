/* file: prob5.c
  author: David De Potter
  description: IP mid2020 resit, problem 5, check
*/

#include <stdio.h>
#include <stdlib.h> 
#include <assert.h>

//=================================================================
// Reads an 8x8 chess board from standard input into a grid
// and stores the position of the king in (x,y)
void readInput(char grid[][8], int *x, int *y){
  for (int i = 0; i < 8; ++i) {
    for (int j = 0; j < 8; ++j) {
      assert(scanf(" %c", &grid[i][j]) == 1);
      if (grid[i][j] == 'k') {
        *x = i;
        *y = j;
      }
    }
  }
}

//=================================================================
// Checks if the king at position (x,y) is in check by any queen
// on the board grid 
int inCheck(char grid[][8], int x, int y) {

    // Directions: down, up, right, left, 
    // down-right, up-left, down-left, up-right
  int dir[] = {1,0,-1,0,0,1,0,-1,1,1,-1,-1,1,-1,-1,1};
  
  for (int i = 0; i < 16; i += 2){
    int dx = x + dir[i];
    int dy = y + dir[i + 1];
    while (dx < 8 && dx >= 0 && dy < 8 && dy >= 0) {
      if (grid[dx][dy] == 'Q') return 1;   
      if (grid[dx][dy] != '#') break;  
      dx += dir[i]; 
      dy += dir[i + 1];
    }
  }
  return 0;
}

//=================================================================

int main() {
  int x, y; 
  char grid[8][8];
  
  readInput(grid, &x, &y);
  
  printf(inCheck(grid, x, y) ? "YES\n" : "NO\n");
  
  return 0;
}