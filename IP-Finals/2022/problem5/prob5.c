/* file: prob5.c
   author: David De Potter
   description: IP Final 2022, problem 5, sum with k elements
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
// Reads an array of size integers from stdin
int *readIntArray(int size){
  int *arr = safeMalloc(size * sizeof(int));
  for (int i = 0; i < size; ++i) 
    assert(scanf("%d", &arr[i]) == 1);
  return arr;
}

//=================================================================
// Checks whether there exists a subset of k elements in 
// arr[0..n-1] that sums up to 'remaining'
int checkSum(int taken, int remaining, int k, int n, int *arr){
    // found a valid subset
  if (taken == k) return remaining == 0;
    // no elements left
  if (n == 0) return 0;
    // not enough elements left to reach k
  if (taken + n < k) return 0; 
    // recursive case: either take or don't take arr[n-1]
  return checkSum(taken, remaining, k, n-1, arr) 
      || checkSum(taken+1, remaining - arr[n-1], k, n-1, arr);
}

//=================================================================

int main(){
  int target, k, n;
  assert(scanf("%d %d %d", &target, &k, &n) == 3);
  int *arr = readIntArray(n);
  printf(checkSum(0, target, k, n, arr) ? "YES\n" : "NO\n");
  free(arr);
  return 0; 
}