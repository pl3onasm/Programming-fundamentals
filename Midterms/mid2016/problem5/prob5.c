/* file: prob5.c
* author: David De Potter
* description: problem 5, Takuzu checker, mid2016
*/

#include <stdio.h>
#include <stdlib.h>

void readTakuzu(int arr[][8]){
  //stores the Takuzu grid into a 2-dim array
  for (int i=0; i < 8; ++i) {    
    for (int j=0; j < 8; ++j)
      arr[i][j] = getchar() - '0';
    getchar();
  }
}

int hasDifferentArrays(int arr[][8]){
  /* checks if there are no identical rows or cols */
  for (int i = 0; i < 8; i++)
    for(int j = i+1; j < 8; j++){
      int count = 0;
      for(int k = 0; k < 8; k++)
        if(arr[i][k] == arr[j][k]) count++;
      if (count == 8) return 0;
    }
  return 1;	   
}

int hasEvenDistribution(int arr[][8]){
  /* checks if the rows or cols have an equal number of 0s and 1s */
  for (int i=0; i < 8; ++i) {
    int zeros = 0; 
    for (int j=0; j < 8; ++j)
      if (arr[i][j] == 0) zeros++;
    if (zeros != 4) return 0;
  }
  return 1; 
} 	

int hasNoThreeAdjacentNumbers(int arr[][8]){
  /* checks if no row or col contains more than two adjacent 0s or 1s */
  for (int i=0; i < 8; ++i) 
    for (int j=0; j < 6; ++j) 
      if (arr[i][j] == arr[i][j+1] &&
          arr[i][j] == arr[i][j+2]) return 0;
  return 1; 
}

int main(int argc, char *argv[]) {
  int rows[8][8], cols[8][8];
  readTakuzu(rows);
  //transposes the matrix in order to do checks on its columns
  for (int i=0; i < 8; ++i)   
    for (int j=0; j < 8; ++j)
      cols[i][j] = rows[j][i];

  /* perform checks on the grid's rows and columns to see if
   * the Takuzu criteria are met */
  if ((hasDifferentArrays(rows)) &&
  (hasNoThreeAdjacentNumbers(rows)) &&
  (hasEvenDistribution(rows)) &&
  (hasDifferentArrays(cols)) &&
  (hasNoThreeAdjacentNumbers(cols)) &&
  (hasEvenDistribution(cols)))
    printf("CORRECT\n");
  else printf("INCORRECT\n");

  return 0;
}
