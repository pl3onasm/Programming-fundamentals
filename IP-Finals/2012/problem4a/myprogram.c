/* file: myprogram.c
   author: your name
   description: IP Final 2012, problem 4a, 
   Iterative algorithms, permutations
*/

#include <stdio.h>
#include <stdlib.h>

int isPermutation(int length, int a[], int b[]){
  /* implement the body of this function */

  // your code here

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
  
}

int main(int argc, char *argv[]) {
  // do not change main
  int a[1000], b[1000], n;
  scanf("%d", &n);
  for (int i = 0; i < n; ++i) scanf("%d", &a[i]);
  for (int i = 0; i < n; ++i) scanf("%d", &b[i]);
  printf(isPermutation(n, a, b) ? "YES\n": "NO\n");
  return 0;
}