/* file: prob5b.c
   author: David De Potter
   description: IP Final 2013, problem 5b, 
   Recursive algorithms, subsequences
*/

#include <stdio.h>
#include <stdlib.h>

int numSubsequences(int n, int m, int s[], int t[]){
  if (m > n) return 0;
  if (m == 0) return 1;
  if (s[n-1] == t[m-1]){ 
    // compute the total number of subsequences if we  
    // include the current element of s and if we don't
    return numSubsequences(n-1, m-1, s, t) + numSubsequences(n-1, m, s, t); 
  }
  return numSubsequences(n-1, m, s, t);
    // elements from s and t don't match, so we skip current element of s
}

int main(int argc, char *argv[]) {
  int n, m, s[200]={0}, t[200]={0}; 
  (void)! scanf("%d %d", &n, &m);
  for (int i = 0; i < n; ++i) (void)! scanf("%d", &s[i]);
  for (int i = 0; i < m; ++i) (void)! scanf("%d", &t[i]);
  printf("%d\n", numSubsequences(n, m, s, t));
  return 0;
}