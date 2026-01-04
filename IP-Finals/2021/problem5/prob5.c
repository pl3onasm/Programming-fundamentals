/* file: prob5.c
   author: David De Potter
   description: IP Final 2021, problem 5, 
      longest palindromic sequence
   complexity: we use a simple recursive solution with time 
      complexity O(2^n). Memoization is possible to reduce 
      this to O(n^2) for larger inputs.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory and checks if it was successful
void *safeCalloc (size_t n, size_t size) {
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    fprintf(stderr, "Error: calloc(%zu, %zu) failed. "
                    "Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Recursively computes the length of the longest palindromic
// subsequence in s[start..end]
int getMaxPal (char *s, int start, int end) {
    // base case
  if (start >= end) 
    return start == end;

    // recursive case: take both if they match
  if (s[start] == s[end])                
    return 2 + getMaxPal(s, start + 1, end - 1);  

    // otherwise, skip one from either end
    // and take the maximum
  int x = getMaxPal(s, start + 1, end);    
  int y = getMaxPal(s, start, end - 1);    

  return x > y ? x : y;
}

//=================================================================

int main(){
  int n; 
  assert(scanf("%d", &n) == 1);
  char *s = safeCalloc(n + 1, sizeof(char));  
  assert(scanf("%s", s) == 1);
  printf("%d\n", getMaxPal(s, 0, n - 1));
  free(s); 
  return 0; 
}
