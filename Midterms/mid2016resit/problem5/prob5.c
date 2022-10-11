/* file: prob5.c
* author: David De Potter
* description: problem 5, sliding n-puzzle, resit mid2016
*/

#include <stdio.h>
#include <stdlib.h>

void fillPuzzle(int n, int puzzle[][8]) {
  for (int i=0; i<n; ++i) 
    for (int j=0; j<n; ++j) 
      scanf("%d", &puzzle[i][j]);
}

void find0 (int x, int n, int* row, int* col, int puzzle[][8]) {
  // find the position of the empty space
  for (int r = 0; r < n; ++r) 
    for (int c = 0; c < n; ++c) 
      if (puzzle[r][c] == x) {
        puzzle[r][c] = 0;
        *row = r; *col = c;
        return;
      }
}

int slide (char dir, int n, int x, int puzzle[][8]) {
  int row=0, col=0, result=0;
  find0 (x, n, &row, &col, puzzle);
  switch (dir) {
    case 'R':
      if ((col + 1 < n) && (puzzle[row][col + 1] == 0)) {
        puzzle[row][col + 1] = x; result = 1;
      }
      break;
    case 'L':
      if ((col - 1 >= 0) && (puzzle[row][col - 1] == 0)) {
        puzzle[row][col - 1] = x; result = 1;
      }
      break;
    case 'D':
      if ((row + 1 < n) && (puzzle[row + 1][col] == 0)) {
        puzzle[row + 1][col] = x; result = 1;
      }
      break;
    case 'U':
      if ((row - 1 >= 0) && (puzzle[row - 1][col] == 0)) {
        puzzle[row - 1][col] = x; result = 1;
      }
      break;
  }
  return result;
}

int checkPuzzle(int n, int puzzle[][8]) {
  // check if puzzle is solved; note that the empty tile 0
  // may be in any position, not just the bottom right corner
  int count=0;
  for (int row = 0; row < n; ++row) 
    for (int col = 0; col < n; ++col) 
      if (puzzle[row][col] != 0) {
        count++;
        if (puzzle[row][col] != count) 
          return 0;
      }
  return 1;
}

int main(int argc, char *argv[]) {
  int n, x=0, valid=1, puzzle[8][8];
  char dir, string[6];
  scanf("%d", &n);
  fillPuzzle(n, puzzle);
  scanf("%s %d", string, &x);
  dir = string[0];
  while (dir != 'E') {
    if (slide(dir, n, x, puzzle)) {
      scanf("%s %d", string, &x);
      dir = string[0];
    } else {
      valid = 0;
      printf("INVALID\n");
      break;
    }
  }
  if (valid) {
    if (checkPuzzle(n, puzzle)) printf("SOLVED\n");
    else printf("UNSOLVED\n");
  }
  return 0;
}
