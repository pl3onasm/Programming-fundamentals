/* 
  file: prob9.c
  author: David De Potter
  description: extra, problem 9, maze runner
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h> 

//=================================================================
// Allocates memory and checks for successful allocation
void *safeCalloc(int n, int size) {
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%d, %d) failed. "
           "Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Deallocates 2D array (matrix) of characters
void freeMem(char **maze, int rows) {
  for (int i = 0; i < rows; ++i) 
    free(maze[i]);
  free(maze);
}

//=================================================================
// Reads the maze from standard input
char **readMaze(int rows, int cols, int *r, int *c) {
  char **maze = safeCalloc(rows, sizeof *maze);

  for (int i = 0; i < rows; ++i) {
    maze[i] = safeCalloc(cols, sizeof *maze[i]);

      // Pre-fill with '#', so any unused cells become walls
    for (int j = 0; j < cols; ++j)
      maze[i][j] = '#';

    int j = 0, ch;
      // Read one line of the maze
    while ((ch = getchar()) != EOF && ch != '\n') 
      if (j < cols) {
        maze[i][j] = ch;
        if (maze[i][j] == '@') {  // starting position
          *r = i;
          *c = j;
        }
        ++j;
      }
  }

  return maze;
}

//=================================================================
// Recursive function to explore the maze and find the longest path
// using Depth-First Search (DFS) with backtracking
int processMaze(char **maze, int rows, int cols, int r, int c) {
  
    // base case: out of bounds, wall or empty cell
  if (r < 0 || r >= rows || c < 0 || c >= cols ||
      maze[r][c] == '#'  || maze[r][c] == ' ')
    return 0;

    // mark cell as visited
  char original = maze[r][c];
  maze[r][c] = ' ';

  int maxLength = 0;
    // direction vectors: up, down, left, right
  static const int dr[] = {-1, 1,  0, 0};
  static const int dc[] = { 0, 0, -1, 1};

    // explore all 4 directions for each step
  for (int k = 0; k < 4; ++k) {
    int ur = r + dr[k];
    int uc = c + dc[k];
    int length = processMaze(maze, rows, cols, ur, uc);
    if (length > maxLength) 
      maxLength = length;
  }

    // unmark (backtrack)
  maze[r][c] = original;
  return original == '.' ? maxLength + 1 : maxLength;
}

//=================================================================

int main() {

  int rows, cols, r, c;
  assert(scanf("%d %d ", &rows, &cols) == 2);

  char **maze = readMaze(rows, cols, &r, &c);

  int length = processMaze(maze, rows, cols, r, c);

  printf("%d\n", length);

  freeMem(maze, rows);

  return 0;
}
