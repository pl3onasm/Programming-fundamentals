/* file: myprogram.c
* author: your name
* description: IP Final 2015 resit, problem 5, recursion
*/

#include <stdio.h>
#include <stdlib.h>

int plusmin(int length, int a[], int n) {
  /* Implement the body of this function.
  * Call a recursive helper function that solves the problem.
  */

  // your code here

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
}

int main() {
  int len, n, i, a[100];
  scanf ("%d %d", &len, &n);
  for (i=0; i < len; i++) {
    scanf("%d", &a[i]);
  }
  printf("%d\n", plusmin(len, a, n));
return 0;

