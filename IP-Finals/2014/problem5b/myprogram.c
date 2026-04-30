/* file: myprogram.c
   author: your name
   description: IP Final 2014, problem 5b, 
   Recursive algorithms, kth smallest element
*/

#include <stdio.h>
#include <stdlib.h>

int kthSmallest(int *arr, int len, int k) {
  /* implement the body of this function */

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
}

int main(int argc, char *argv[]) {
  // do not change main
  int n, k, arr[100], len=0;
  scanf("%d", &k);
  while (scanf("%d", &n) == 1) 
    arr[len++] = n;
  printf("%d\n", kthSmallest(arr, len, k));
  return 0;
}