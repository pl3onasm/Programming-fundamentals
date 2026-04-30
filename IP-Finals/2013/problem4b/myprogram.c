/* file: myprogram.c
   author: your name
   description: IP Final 2013, problem 4b, 
   Iterative algorithms, latin square
*/

#include <stdio.h>
#include <stdlib.h>

int isLatinSquare(int arr[][200], int N){
  /* implement the body of this function */

  // your code here

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
}

int main(int argc, char *argv[]) {
  // do not change main
  int n, square[200][200];
  scanf("%d", &n); 
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      scanf("%d", &square[i][j]);
  printf(isLatinSquare(square, n) ? "YES\n" : "NO\n");
  return 0;
}
