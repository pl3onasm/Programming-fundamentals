/* file: myprogram.c
* author: your name
* description: IP Final 2016, problem 5, balanced subsequences
*/

#include <stdio.h>
#include <stdlib.h>

int numberOfBalancedSubsets(int length, int a[]) {
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
  int n, i, seq[20];
  scanf ("%d\n", &n);
  for (i=0; i < n; i++) {
    scanf("%d", &seq[i]);
  }
  printf("%d\n", numberOfBalancedSubsets(n, seq));
  return 0;
}