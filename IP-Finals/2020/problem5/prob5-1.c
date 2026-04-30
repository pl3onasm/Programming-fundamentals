/* file: prob5-1.c
   author: David De Potter
   version: 5.1, using a void function
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
// Computes the maximal sum by choosing elements from vec
// with the constraint that no more than two consecutive
// elements can be chosen
void maximize(int *vec, int idx, int len, int sum, int *max){
  
    // base case: no elements left, check current sum 
    // and update maximum accordingly
  if (idx < 0){
    *max = sum > *max ? sum : *max;
    return;
  }
    // recursive case: either take (if possible) or skip
    // the current element vec[idx]
  if (len < 2) maximize(vec, idx -1, len + 1, sum + vec[idx], max);
    
    // skip
  maximize(vec, idx - 1, 0, sum, max);  
}

//=================================================================

int main(){
  int n, max = 0; 
  assert(scanf("%d: ", &n) == 1);

  int *vec = readIntVector(n); 
  
  maximize(vec, n - 1, 0, 0, &max); 
  
  printf("%d\n", max);
  free(vec);
  return 0; 
}