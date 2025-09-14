/* file: prob5.c
   author: David De Potter
   description: PF 1/3rd term 2023, problem 5, sliding puzzle
   A slightly different solution can be found under mid2016resit/problem5/prob5.c
*/

#include <stdio.h>
#include <stdlib.h>

void readPuzzle(int n, int eCell[], int puzzle[][8]) {
  for (int i=0; i<n; ++i) 
    for (int j=0; j<n; ++j) {
      (void)! scanf("%d", &puzzle[i][j]);
      if (puzzle[i][j] == 0)        
        eCell[0] = i, eCell[1] = j;  // found position of empty cell
    }
}

void swapTiles(int puzzle[][8], int eCell[], int tile, int tRow, int tCol) {
  // swap tile with empty cell
  puzzle[eCell[0]][eCell[1]] = tile; // tile moves to empty cell
  puzzle[tRow][tCol] = 0;            // empty cell moves to tile's position
  eCell[0] = tRow, eCell[1] = tCol;  // update position of empty cell
}

int slide (char dir, int n, int tile, int eCell[], int puzzle[][8]) {
  // slide the tile in the direction dir (R, L, U, D) if possible
  int const eRow = eCell[0], eCol = eCell[1];
  // try to move tile in the direction dir
  if (dir == 'R' && eCol > 0 && tile == puzzle[eRow][eCol-1]) 
    swapTiles(puzzle, eCell, tile, eRow, eCol-1);
  if (dir == 'L' && eCol < n-1 && tile == puzzle[eRow][eCol+1])
    swapTiles(puzzle, eCell, tile, eRow, eCol+1);
  if (dir == 'U' && eRow < n-1 && tile == puzzle[eRow+1][eCol])
    swapTiles(puzzle, eCell, tile, eRow+1, eCol);
  if (dir == 'D' && eRow > 0 && tile == puzzle[eRow-1][eCol])
    swapTiles(puzzle, eCell, tile, eRow-1, eCol);
  // return 1 if tile was moved, 0 otherwise
  return eCell[0] != eRow || eCell[1] != eCol;  
}

int checkPuzzle(int n, int puzzle[][8]) {
  // check if puzzle is solved by checking if the numbers are in
  // ascending order, starting from 1, and skipping the empty cell
  int count = 0;
  for (int row = 0; row < n; ++row) 
    for (int col = 0; col < n; ++col) 
      if (puzzle[row][col] && puzzle[row][col] != ++count) 
        return 0;       
  return 1;
}

int main(int argc, char *argv[]) {
  int n, tile, puzzle[8][8];
  int eCell[2];             // position of empty cell
  char dir[6];              // direction to slide tile in
  (void)! scanf("%d", &n);  // read size of puzzle
  readPuzzle(n, eCell, puzzle);
  while (scanf("%s %d", dir, &tile) && dir[0] != 'E') {
    if (! slide(dir[0], n, tile, eCell, puzzle)){
      // slide function returns 0 if the move is not possible
      printf("INVALID\n");
      return 0;
    }
  }
  // all moves are valid, check if puzzle is solved
  printf(checkPuzzle(n, puzzle) ? "SOLVED\n" : "UNSOLVED\n");
  return 0;
}
