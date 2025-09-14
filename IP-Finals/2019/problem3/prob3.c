/* file: prob3.c
   author: David De Potter
   description: IP Final 2019, problem 3, 
   Towers of Hanoi
*/

#include <stdio.h>
#include <stdlib.h>

int putDisc(int n, int from, int to, int i, int rods[3][10]){
  int disc=0, j, k, flag=0; 
  for (j = 0; j < n; j++)
    if (rods[from][j]){
      disc = rods[from][j];
      rods[from][j] = 0;
      break;
    }
  for (k = 0; k < n; k++){
    if (rods[to][k]){
      rods[to][k-1] = disc;
      if (rods[to][k] < disc) flag = 1; // wrong disc order
      break;
    }
    if (k == n-1) rods[to][k] = disc;
  }
  if (flag || j == n) {     // if j == n, no disc was found
    printf("ILLEGAL MOVE %d\n", i+1);
    return 1;
  }
  return 0; 
}

int main(int argc, char **argv){
  int n, m, rods[3][10]={0}, from, to;
  (void)! scanf("%d %d ", &n, &m);
  for (int i = 0; i < n; i++)
    rods[0][i] = i+1;
  for (int i = 0; i < m; i++) {
    (void)! scanf("%d->%d ", &from, &to);
    int illegal = putDisc(n, from, to, i, rods);
    if (illegal) return 0; 
  } 
  if (rods[1][0] == 1 || rods[2][0] == 1) 
    printf("SOLVED\n"); 
  else printf("UNSOLVED\n"); 
  return 0; 
}