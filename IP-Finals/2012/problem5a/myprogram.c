/* file: myprogram.c
   author: your name
   description: IP Final 2012, problem 5a, 
   Recursive algorithms, reaching a number,
   using brute force
*/

#include <stdio.h>
#include <stdlib.h>

int reach (int a, int n) {
  /* implement the body of this function */
  

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
}

int main(int argc, char *argv[]) {
  // do not change main
  int a, n;
  scanf("%d %d", &a, &n);  
  printf("%d\n", reach(a, n));
  return 0;
}