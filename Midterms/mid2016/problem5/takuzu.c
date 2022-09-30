/* file: takuzu.c
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

int hasNoIdenticalArrays(int arr[][8]){
  /* checks if the Takuzu grid has no identical rows
   * (or columns if the input consists of the transpose) */
  int counter = 0;
  for (int i = 0; i <= 6; i++){
    for(int j = i+1; j <= 7; j++){
      for(int k = 0; k < 8; k++)
        if(arr[i][k] == arr[j][k]) counter++;
      if (counter == 8) return 0;
      counter = 0;
    }
  }
  return 1;	   
}

int hasEvenlyDistributedNumbers(int arr[][8]){
  /* checks if the grid's rows have an equal amount of 0s and 1s
   * (same for columns if the input consists of the transpose) */
  int counter0 = 0; 
  for (int i=0; i < 8; ++i) {
    for (int j=0; j < 8; ++j)
      if (arr[i][j] == 0) counter0++;
    if (counter0 != 4) return 0;
    counter0 = 0;
  }
  return 1; 
} 	

int hasNoThreeAdjacentNumbers(int arr[][8]){
  /* checks if no row contains more than two adjacent 0s or 1s
   * (same for columns if the input consists of the transpose) */
  for (int i=0; i < 8; ++i) {
    for (int j=0; j <= 5; ++j) {
      if ((arr[i][j] == arr[i][j+1]) &&
         (arr[i][j] == arr[i][j+2])) return 0;
    }
  }
  return 1; 
}

int main(int argc, char *argv[]) {
  int rows[8][8], cols[8][8];
  readTakuzu(rows);
  //transposes the matrix in order to do checks on its columns
  for (int i=0; i < 8; ++i) {    
    for (int j=0; j < 8; ++j)
      cols[i][j] = rows[j][i];
  }

  /* perform checks on the grid's rows and columns to see if
   * it meets the Takuzu criteria */
  if ((hasNoIdenticalArrays(rows)) &&
  (hasNoThreeAdjacentNumbers(rows)) &&
  (hasEvenlyDistributedNumbers(rows)) &&
  (hasNoIdenticalArrays(cols)) &&
  (hasNoThreeAdjacentNumbers(cols)) &&
  (hasEvenlyDistributedNumbers(cols))) {
    printf("CORRECT\n");
  } else printf("INCORRECT\n");

  return 0;
}
