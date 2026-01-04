/* file: prob4b.c
   author: David De Potter
   description: IP Final 2013, problem 4b, 
   Iterative algorithms, latin square
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks if arr is a latin square of size N x N
int isLatinSquare(int arr[][200], int N){

    // Value range check: all values must be between 1 and N
  for (int i = 0; i < N; ++i){
    for (int j = 0; j < N; ++j){
      if (arr[i][j] < 1 || arr[i][j] > N)
        return 0;
    }
  }

    // Row check
  for (int i = 0; i < N; ++i){
    int count[200] = {0};
    for (int j = 0; j < N; ++j) 
      count[arr[i][j] - 1]++;
    for (int v = 0; v < N; ++v)
      if (count[v] != 1) return 0;
  }

    // Column check
  for (int j = 0; j < N; ++j){
    int count[200] = {0};
    for (int i = 0; i < N; ++i) 
      count[arr[i][j] - 1]++;
    for (int v = 0; v < N; ++v)
      if (count[v] != 1) return 0;
  }

  return 1;
}

//=================================================================

int main() {
  int n, square[200][200];

  assert(scanf("%d", &n) == 1); 
  
  for (int i = 0; i < n; ++i)
    for (int j = 0; j < n; ++j)
      assert(scanf("%d", &square[i][j]) == 1);

  printf(isLatinSquare(square, n) ? "YES\n" : "NO\n");

  return 0;
}