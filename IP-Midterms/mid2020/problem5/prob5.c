/* file: prob5.c
  author: David De Potter
  description: IP mid2020, problem 5, connect four
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================
// Finds the first empty cell in the given column of the grid
// Returns the row index, or -1 if the column is full
int findEmptyCell(int grid[][7], int col) {
  int row = 5;
  while (row >= 0 && grid[row][col]) --row;
  return row; 
}

//=================================================================
// Checks if current player has won after placing a disc at 
// (row,col)
int checkWin (int grid[][7], int row, int col) {
  int dir[] = {1,0,-1,0,0,1,0,-1,1,1,-1,-1,1,-1,-1,1};
  int count = 0;

    // Count discs in each of the 4 directions
  for (int i = 0; i < 16; i += 2) {
    if (i % 4 == 0) count = 1; 
    int r = row + dir[i], c = col + dir[i + 1];
    while (r >= 0 && r < 6 && c >= 0 && c < 7 
           && grid[r][c] == grid[row][col]) {
      ++count;
      r += dir[i];
      c += dir[i + 1];
    }
    if (count >= 4) return 1;
  }
  return 0;
}

//=================================================================
// Fills the grid according to input moves and checks for a win
// Returns 0 if yellow wins, 1 if red wins, -1 if undecided
int fillGrid(int grid[][7]) {
  int turn = 0, row, col; 
  while(scanf("%d%*[,]", &col) == 1) {
    row = findEmptyCell(grid, col);
      // if column full, ignore move
    if (row == -1) continue;
      // yellow starts (turn 0), then alternate
      // yellow disc = 1, red disc = 2
    grid[row][col] = (turn % 2) + 1; 
      // after each move, check for a win
    if (checkWin(grid, row, col)) 
      return turn % 2;
    ++turn;
  }
  return -1;
}

//=================================================================

int main() {
  int grid[6][7] = {0}; 
  int r = fillGrid(grid);
  
  if (r > 0) printf("RED\n");
  else if (r < 0) printf("UNDECIDED\n");
  else printf("YELLOW\n");
  return 0;
}