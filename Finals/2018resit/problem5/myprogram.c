/* file: myprogram.c
* author: your name
* description: IP Final 2018 Resit, problem 5, minimal palindromic partition
*/

#include <stdio.h>
#include <stdlib.h>

int minimalPalPartition(int i, int j, char *a) {
  /* Implement the body of this function.
  * Moreover, this function must be recursive, or
  * it should call a recursive helper function.
  */

  // your code here

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
}

int main(int argc, char *argv[]) {
  char a[21];
  scanf("%s", a);
  printf("%d\n", minimalPalPartition(0, strlen(a)-1, a));
  return 0;
}