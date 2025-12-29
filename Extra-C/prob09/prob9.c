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
void *safeCalloc(size_t n, size_t size) {
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%zu, %zu) failed. "
           "Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Deallocates 2D array (matrix) of characters
void freeMem(char **maze, size_t rows) {
  for (size_t i = 0; i < rows; ++i) 
    free(maze[i]);
  free(maze);
}

//=================================================================
// Reads the maze from standard input
char **readMaze(size_t rows, size_t cols, size_t *r, size_t *c) {
  char **maze = safeCalloc(rows, sizeof(char *));

  for (size_t i = 0; i < rows; ++i) {
    maze[i] = safeCalloc(cols, sizeof (char));

      // Pre-fill with '#', so any unused cells become walls
    for (size_t j = 0; j < cols; ++j)
      maze[i][j] = '#';

    size_t j = 0;
    int ch;
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
size_t processMaze(char **maze, size_t rows, size_t cols, 
                   size_t r, size_t c) {
  
    // base case: out of bounds, wall or empty cell
  if (r >= rows || c >= cols ||
      maze[r][c] == '#'  || maze[r][c] == ' ')
    return 0;

    // mark cell as visited
  char original = maze[r][c];
  maze[r][c] = ' ';

   size_t maxLength = 0;
    // direction vectors: up, down, left, right
  static const int dr[] = {-1, 1,  0, 0};
  static const int dc[] = { 0, 0, -1, 1};

    // explore all 4 directions for each step
  for (size_t k = 0; k < 4; ++k) {
    int ur = r + dr[k];
    int uc = c + dc[k];
    size_t length = processMaze(maze, rows, cols, ur, uc);
    if (length > maxLength) 
      maxLength = length;
  }

    // unmark (backtrack)
  maze[r][c] = original;
  return original == '.' ? maxLength + 1 : maxLength;
}

//=================================================================

int main() {

  size_t rows, cols, r, c;
  assert(scanf("%zu %zu ", &rows, &cols) == 2);

  char **maze = readMaze(rows, cols, &r, &c);

  size_t length = processMaze(maze, rows, cols, r, c);

  printf("%zu\n", length);

  freeMem(maze, rows);

  return 0;
}
