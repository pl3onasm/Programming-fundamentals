/* file: prob5.c
  author: David De Potter
  description: IP mid2020, problem 5, connect four
*/

#include <stdio.h>
#include <stdlib.h>

int checkEmptyCell(int grid[][7], int col) {
  //returns row index with first empty cell in given column
  int row = 5;
  while (grid[row][col] > 0) row--; 
  return row; 
}

int checkWin (int grid[][7], int row, int col) {
  int dir[] = {1, 0, 0, 1, 1, 1, -1, 1};
  for (int i = 0; i < 8; i += 2) {
    int count = 1;
    for (int mult = -1; mult <= 1; mult += 2) {
      int r = row + mult * dir[i];
      int c = col + mult * dir[i+1];
      while (r >= 0 && r < 6 && c >= 0 && c < 7 && grid[r][c] == grid[row][col]) {
        count++;
        r += mult * dir[i];
        c += mult * dir[i+1];
      }
    }
    if (count >= 4) return 1;
  }
  return 0;
}

int fillGrid(int grid[][7]) {
  //yellow discs are represented by 1, red ones by 2
  int turn=0, row, col; 
  while(scanf("%d,", &col) == 1) {
    row = checkEmptyCell(grid, col);
    if (turn % 2 == 0) grid[row][col] = 1; //yellow disc
    else grid[row][col] = 2;  //red disc
    if (checkWin(grid, row, col)) return turn % 2;
    turn++;
  }
  return -1;
}

int main(int argc, char *argv[]) {
  int grid[6][7] = {0}; // initializes grid with zeros
  int r = fillGrid(grid);

  if (r > 0) printf("RED\n");
  else if (r < 0) printf("UNDECIDED\n");
  else printf("YELLOW\n");

  return 0;
}