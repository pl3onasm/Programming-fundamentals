/* file: myprogram.c
   author: your name
   description: IP Final 2013, problem 5a, 
   Recursive algorithms, recursive multiplication
*/

#include <stdio.h>
#include <stdlib.h>

int mul(a, b) {
  // your code here
  // you may only use recursion, no loops
  // and you may only use addition and subtraction
  // using multiplicaton and division is not allowed


  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
}

int main(int argc, char *argv[]) {
  int a, b;
  scanf("%d %d", &a, &b);
  printf("%d\n", mul(a, b));  
  return 0;
}