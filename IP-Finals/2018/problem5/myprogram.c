/* file: myprogram.c
* author: your name
* description: IP Final 2018, problem 5, pattern matching
*/

#include <stdio.h>
#include <stdlib.h>

int isMatch(char *pattern, char *string) {
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
  char pattern[30], string[30];
  scanf("%s %s", pattern, string);
  if (isMatch(pattern, string) == 0) {
    printf("NO ");
  }
  printf("MATCH\n");
  return 0;
}