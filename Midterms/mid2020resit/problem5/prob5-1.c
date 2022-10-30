/* file: prob5-1.c
  author: David De Potter
  description: IP mid2020 resit, problem 5, check
*/

#include <stdio.h>
#include <stdlib.h> 

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
    while ((ux<8 && ux>=0) && (uy<8 && uy>=0)) {
      if (grid[ux][uy] == 'Q') return 1;   
      if (grid[ux][uy] == 'p') break;  
      if (grid[ux][uy] == 'K') break;
      ux += dirx; uy += diry;
    }
  }
  return 0;
}

int main(int argc, char *argv[]) {
  int x, y; char grid[8][8];
  readInput(grid, &x, &y);

  if (inCheck(grid, x, y)) printf("YES\n");
  else printf("NO\n"); 

  return 0;
}