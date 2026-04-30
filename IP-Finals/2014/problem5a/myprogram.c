/* file: myprogram.c
   author: your name
   description: IP Final 2014, problem 5a, Recursive algorithms,
   recursive addition
*/

#include <stdio.h>
#include <stdlib.h>

int add(a, b){
  // your code here
  // you may only use recursion, no loops
  // and you may only use plus one and minus one


  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
}

int main(int argc, char *argv[]) {
  // do not change main
  int a, b;
  scanf("%d %d", &a, &b);
  printf("%d\n", add(a, b));  
  return 0;
}
