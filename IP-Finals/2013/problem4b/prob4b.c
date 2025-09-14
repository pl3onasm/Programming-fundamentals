/* file: prob4b.c
   author: David De Potter
   description: IP Final 2013, problem 4b, 
   Iterative algorithms, latin square
*/

#include <stdio.h>
#include <stdlib.h>

int isLatinSquare(int arr[][200], int N){
  for (int i = 0; i < N; ++i){
    for (int j = 0; j < N; ++j){
      if (arr[i][j] < 1 || arr[i][j] > N)
        return 0;
    }
  }
  int count[200];
  for (int i = 0; i < N; ++i){
    for (int j = 0; j < N; ++j){
      count[j] = 0;
    }
    for (int j = 0; j < N; ++j){
      count[arr[i][j] - 1]++;
    }
    for (int j = 0; j < N; ++j){
      if (count[j] != 1)
        return 0;
    }
  }
  return 1;
}

int main(int argc, char *argv[]) {
  int n, square[200][200];
  (void)! scanf("%d", &n); 
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      (void)! scanf("%d", &square[i][j]);
  printf(isLatinSquare(square, n) ? "YES\n" : "NO\n");
  return 0;
}