/* file: myprogram.c
   author: your name
   description: IP Final 2014, problem 4a, Iterative algorithms,
   factorial sum
*/

#include <stdio.h>
#include <stdlib.h>

int isFactorialSum(int n) {
  /* implement the body of this function */

  // your code here

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
  
}

int main(int argc, char *argv[]) {
  // do not change main
  int a; 
  scanf("%d", &a);
  printf(isFactorialSum(a) ? "YES\n" : "NO\n");
  return 0;
}