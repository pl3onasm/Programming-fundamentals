/* file: prob5-2.c
   author: David De Potter
   version: 5.2, using an int function
   description: IP Final 2020, problem 5, choice maximization
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory and checks for allocation errors
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    fprintf(stderr, "Error: malloc(%zu) failed. "
                    "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Reads an integer vector from standard input
int *readIntVector(int size) {
  int i, *vec = safeMalloc(size * sizeof(int));
  for (i = 0; i < size; ++i) 
    assert(scanf("%d", &vec[i]) == 1);
  return vec;
}

//=================================================================
// Computes the maximal sum by choosing elements from vec with the
// constraint that no more than two consecutive elements can be 
// chosen
int maximize(int *vec, int idx, int len){
  int x = 0, y = 0; 

    // base case: no elements left, finalize sum 
  if (idx < 0) 
    return 0;

    // recursive case: either take (if possible) or skip
    // the current element vec[idx], and return the maximum sum
  if (len < 2) x = vec[idx] + maximize(vec, idx - 1, len + 1);
    
    // skip
  y = maximize(vec, idx - 1, 0);
  
  return x > y ? x : y;  
}

//=================================================================

int main(){
  int n; 
  assert(scanf("%d: ", &n) == 1);

  int *vec = readIntVector(n); 
  
  printf("%d\n", maximize(vec, n - 1, 0));
  
  free(vec);
  return 0; 
}
