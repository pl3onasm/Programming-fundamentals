/* file: prob5.c
   author: David De Potter
   description: PF 1/3rd term 2023, problem 5, sliding puzzle
   Time complexity: O(m + n^2), with m the number of moves 
     and n the size of the puzzle
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Reads the puzzle from standard input
void readPuzzle(int n, int eCell[], int puzzle[][8]) {
  for (int i=0; i<n; ++i) 
    for (int j=0; j<n; ++j) {
      assert(scanf("%d", &puzzle[i][j]) == 1);
      if (puzzle[i][j] == 0)        
          // store position of empty cell
        eCell[0] = i, eCell[1] = j;  
    }
}

//=================================================================
// Swaps the tile with the empty cell
void swapTiles(int puzzle[][8], int eCell[], int tile, int tRow, 
               int tCol) {
    // tile moves to empty cell
  puzzle[eCell[0]][eCell[1]] = tile; 
    // empty cell moves to tile's position
  puzzle[tRow][tCol] = 0;           
    // update position of empty cell
  eCell[0] = tRow, eCell[1] = tCol;  
}

//=================================================================
// Slides the tile in the specified direction if possible
// Returns 1 if the tile was moved, 0 otherwise
int slide (char dir, int n, int tile, int eCell[], 
           int puzzle[][8]) {
  int eRow = eCell[0], eCol = eCell[1];
    
    // try to move tile in the direction dir
  switch (dir) {
    case 'R': if (eCol > 0   && puzzle[eRow][eCol-1] == tile) 
              swapTiles(puzzle, eCell, tile, eRow, eCol-1); 
    break;
    case 'L': if (eCol < n-1 && puzzle[eRow][eCol+1] == tile) 
              swapTiles(puzzle, eCell, tile, eRow, eCol+1); 
    break;  
    case 'U': if (eRow < n-1 && puzzle[eRow+1][eCol] == tile) 
              swapTiles(puzzle, eCell, tile, eRow+1, eCol); 
    break;  
    case 'D': if (eRow > 0   && puzzle[eRow-1][eCol] == tile) 
              swapTiles(puzzle, eCell, tile, eRow-1, eCol); 
    break;
  }
    // return 1 if tile was moved, 0 otherwise
  return eCell[0] != eRow || eCell[1] != eCol;  
}

//=================================================================
// Checks if the puzzle is solved by verifying if the numbers are 
// in ascending order, starting from 1, and skipping the empty cell
int checkPuzzle(int n, int puzzle[][8]) {
  int count = 0;
  for (int row = 0; row < n; ++row) 
    for (int col = 0; col < n; ++col) 
      if (puzzle[row][col] && puzzle[row][col] != ++count) 
        return 0;       
  return 1;
}

//=================================================================

int main() {
  int n, tile, puzzle[8][8];
  int eCell[2];               // position of empty cell
  char dir[6];                // direction to slide tile in

  assert(scanf("%d", &n) == 1);    
  readPuzzle(n, eCell, puzzle);

  while (scanf("%s %d", dir, &tile) == 2 && dir[0] != 'E') {
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
