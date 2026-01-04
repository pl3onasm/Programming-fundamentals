/* file: prob5b.c
   author: David De Potter
   description: IP Final 2013, problem 5b, 
   Recursive algorithms, subsequences
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Counts the number of times t appears as a subsequence in s
int numSubsequences(int n, int m, int s[], int t[]){

      // Base case: all elements of t have been matched
  if (m == 0) return 1;
    
      // Base case: s is exhausted but t is not
  if (n == 0) return 0;

      // Recursive case: current elements match
  if (s[n - 1] == t[m - 1]){ 
      // compute the total number of subsequences by
      // including the current element of s
      // or by excluding it
    return numSubsequences(n - 1, m - 1, s, t) 
         + numSubsequences(n - 1, m, s, t); 
  }
      // Recursive case: current elements don't match, 
      // skip current element of s
  return numSubsequences(n - 1, m, s, t);
    
}

//=================================================================

int main() {
  int n, m, s[200] = {0}, t[200] = {0}; 
  
  assert(scanf("%d %d", &n, &m) == 2);

  for (int i = 0; i < n; ++i) 
    assert(scanf("%d", &s[i]) == 1);

  for (int i = 0; i < m; ++i) 
    assert(scanf("%d", &t[i]) == 1);
  
  printf("%d\n", numSubsequences(n, m, s, t));
  
  return 0;
}