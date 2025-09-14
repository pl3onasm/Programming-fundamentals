/* file: myprogram.c
   author: your name
   description: IP Final 2013, problem 5b, 
   Recursive algorithms, subsequences
*/

#include <stdio.h>
#include <stdlib.h>

int numSubsequences(int lenS, int lenT, int s[], int t[]){
  /* return the number of subsequences of s that are equal to t */
  
  // your code here

  // to test your code, run the test script in the terminal: 
  // $ ../../../ctest.sh myprogram.c
  // after you made it executable by running: 
  // $ chmod +x ../../../ctest.sh (you only need to do this once)
}

int main(int argc, char *argv[]) {
  // do not change main
  int n, m, s[200]={0}, t[200]={0}; 
  scanf("%d %d", &n, &m);
  for (int i = 0; i < n; ++i) scanf("%d", &s[i]);
  for (int i = 0; i < m; ++i) scanf("%d", &t[i]);
  printf("%d\n", numSubsequences(n, m, s, t));
  return 0;
}