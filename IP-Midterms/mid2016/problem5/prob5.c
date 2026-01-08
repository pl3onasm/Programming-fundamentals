/* file: prob5.c
   author: David De Potter
   description: problem 5, Takuzu checker, mid2016
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Reads the Takuzu grid from input
void readTakuzu(int arr[][8]){
  for (int i = 0; i < 8; ++i) 
    for (int j = 0; j < 8; ++j)
      assert(scanf("%1d%*[\n]", &arr[i][j]) == 1);
}

//=================================================================
// Checks if there are no identical rows or cols
int hasDiffArrays(int arr[][8]){
  for (int i = 0; i < 8; ++i)
    for(int j = i + 1; j < 8; ++j){
      int equal = 1;
      for(int k = 0; k < 8; ++k)
        if(arr[i][k] != arr[j][k]) {
          equal = 0;
          break;
        }
      if (equal) return 0;
    }
  return 1;
}

//=================================================================
// Checks if each row or col has an equal number of 0s and 1s
int hasEvenDistr(int arr[][8]){
  for (int i = 0; i < 8; ++i) {
    int zeros = 0; 
    for (int j = 0; j < 8; ++j)
      if (arr[i][j] == 0) ++zeros;
    if (zeros != 4) return 0;
  }
  return 1; 
} 	

//=================================================================
// Checks if no row or col contains more than two adjacent 0s or 1s
int hasNoThreeAdjNums(int arr[][8]){
  for (int i = 0; i < 8; ++i) 
    for (int j = 0; j < 6; ++j) 
      if (arr[i][j] == arr[i][j + 1] &&
          arr[i][j] == arr[i][j + 2]) return 0;
  return 1; 
}

//=================================================================

int main() {
  int rows[8][8], cols[8][8];

  readTakuzu(rows);
  
    // transposes the matrix in order to 
    // do checks on its columns
  for (int i = 0; i < 8; ++i)   
    for (int j = 0; j < 8; ++j)
      cols[i][j] = rows[j][i];

  if ((hasDiffArrays    (rows)) &&
      (hasNoThreeAdjNums(rows)) &&
      (hasEvenDistr     (rows)) &&
      (hasDiffArrays    (cols)) &&
      (hasNoThreeAdjNums(cols)) &&
      (hasEvenDistr     (cols)))
    printf("CORRECT\n");

  else printf("INCORRECT\n");

  return 0;
}
