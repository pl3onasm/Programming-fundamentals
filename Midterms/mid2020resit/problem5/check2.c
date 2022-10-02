/* file: check.c
  author: David De Potter
  description: IP mid2020 resit, problem 5, check
  extra feature: if check, it prints the board with the path of attack
*/

#include <stdio.h>
#include <stdlib.h> 

void printGrid(char grid[8][8]) {
  for(int i=0; i<8; i++){
    for(int j=0; j<8; j++)
      printf("%c ",grid[i][j]);
    printf("\n");
  }
  printf("\n"); 
}

void readInput(char grid[8][8], int *x, int *y){
  for (int i=0; i<8; ++i) {
    for (int j=0; j<8; j++) {
      scanf("%c", &grid[i][j]);
      if (grid[i][j] == 'k') {
        *x = i;
        *y = j;
      }
    }
    getchar();  //gets newline character
  }
}

int inCheck(char grid[8][8], int x, int y) {
  int ux, uy, dirx, diry; 
  int dir[]={1,0,-1,0,0,1,0,-1,1,1,-1,1,-1,-1,1,-1}; 
  for (int i=0; i<16; i+=2){
    dirx = dir[i]; diry = dir[i+1];  
    ux = x+dirx; uy = y+diry; 
    int path[16] = {0}, k=0;
    while ((ux<8 && ux>=0) && (uy<8 && uy>=0)) {
      if (grid[ux][uy] == 'Q') {
        for (int h=0; h<k; h+=2)
          grid[path[h]][path[h+1]] = '+';
        return 1;  
      } 
      if (grid[ux][uy] == 'p') break;  
      if (grid[ux][uy] == 'K') break;
      path[k] = ux; path[k+1] = uy;
      ux += dirx; uy += diry;
      k+=2;
    }
  }
  return 0;
}

int main(int argc, char *argv[]) {
  int x, y; char grid[8][8];
  readInput(grid, &x, &y);

  if (inCheck(grid, x, y)) {
    printf("YES\n\nPath of attack (+):\n");
    printGrid(grid);
  } else printf("NO\n"); 

  
  return 0;
}