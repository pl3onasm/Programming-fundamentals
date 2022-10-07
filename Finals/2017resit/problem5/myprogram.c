/* file: myprogram.c
* author: your name
* description: IP Final 2017 Resit, problem 5, sums and products
*/

#include <stdio.h>
#include <stdlib.h>

int prodSum(int n) {
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
  int n;
  scanf("%d", &n);
  printf("%d\n", prodSum(n));
  return 0;
}
