/* file: myprogram.c
* author: your name
* description: IP Final 2017, problem 5, puzzle
*/

#include <stdio.h>
#include <stdlib.h>

int isSolvable(int len, int series[]) {
  /* Implement the body of this function.
  * Moreover, this function should call a recursive helper
  * function that solves the problem.
  */

  // your code here

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)

}

int main(int argc, char *argv[]) {
  int len=0, series[20];
  do {
    scanf("%d", &series[len]);
    len++;
  } while (series[len-1] != 0);
  printf("%d\n", isSolvable(len, series));
  return 0;
}