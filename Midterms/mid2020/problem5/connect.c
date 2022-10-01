/* file: connect.c
  author: David De Potter
  description: IP mid2020, problem 5, connect four
*/

#include <stdio.h>
#include <stdlib.h>

int checkEmptyCell(int grid[][7], int col) {
  //returns the row index where first empty cell is found in given column
  int row = 0;
  while (grid[row][col] != 0) row++; 
  return row; 
}

void fillGrid(int grid[][7]) {
  //yellow discs are represented by 1, red ones by 2
  char c; int turn=0, row, col; 
  while(1) {
    col = getchar() - '0'; 
    row = checkEmptyCell(grid, col);
    if (turn % 2 == 0) grid[row][col] = 1;  //yellow disc
    else grid[row][col] = 2;  //red disc
    if ((c = getchar()) == '#') return; //reads comma or #
    turn++;
  }
}

char checkGrid(int grid[][7]) {
  //check rows
  int c, r, yel, red;
  for (r=0; r<6; r++) {
    for (c=0; c<4; c++) {
      red=yel=0;
      for (int i=0; i<4; i++) {
        if (grid[r][c+i] == 1) yel++;
        else if (grid[r][c+i] == 2) red++;
        else break;
      }
    if (yel == 4) return 'y';
    if (red == 4) return 'r';
    }
  } 
  //check columns
  for (c=0; c<7; c++) {
    for (r=0; r<3; r++) {
      red=yel=0;
      for (int i=0; i<4; i++) {
        if (grid[r+i][c] == 1) yel++;
        else if (grid[r+i][c] == 2) red++;
        else break;
      }
    if (yel == 4) return 'y';
    if (red == 4) return 'r';
    }
  } 
  //check diagonals to the right (bottom-up)
  for (r=0; r<3; r++) {
    for (c=0; c<4; c++) {
      yel=red=0;
      for (int i=0; i<4; i++) {
        if (grid[r+i][c+i] == 1) yel++;
        else if (grid[r+i][c+i] == 2) red++;
        else break;
      }
      if (yel == 4) return 'y';
      if (red == 4) return 'r';
    }
  }
  //check diagonals to the left (bottom-up)
  for (c=3; c<7; c++) {
    for (r=0; r<3; r++) {
      yel=red=0;
      for (int i=0; i<4; i++) {
        if (grid[r+i][c-i] == 1) yel++;
        else if (grid[r+i][c-i] == 2) red++;
        else break;
      }
      if (yel == 4) return 'y';
      if (red == 4) return 'r';
    }
  }
  return 'u'; 
}

int main(int argc, char *argv[]) {
  int grid[6][7] = {0}; //initializes grid with zeros
  fillGrid(grid);
  char c = checkGrid(grid);

  if (c=='r') printf("RED\n");
  else if (c=='y') printf("YELLOW\n");
  else printf("UNDECIDED\n");

  return 0;
}