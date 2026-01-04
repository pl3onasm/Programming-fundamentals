/* file: prob4-2.c
   author: David De Potter
   version: 4.2, in this version we optimize
      from the previous version to a solution
      in O(n log (totalSum)) time using binary search
      This can be further optimized by e.g. setting the 
      left bound to max element in arr 
   description: IP Final 2018, problem 4, split3
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
// Checks whether a solution can be found below mid, i.e. if  
// there exists a 3-way split such that maxsum <= mid
int isSolvable (int *arr, int n, int mid){
  int sum = 0, split = 0; 
  for (int i = 0; i < n; ++i){
    if (arr[i] > mid) 
      return 0;             // element too large
    sum += arr[i];
    if (sum > mid){
      sum = arr[i];
      if (++split > 2) 
        return 0;           // too many splits
    }
  }                   
  return 1;                 // solution found          
}

//=================================================================
// Binary search through the solution space, which consists of
// a (virtual) ordered array of increasing maxsums. Returns the
// lower bound of the solution space
int binSearch (int *arr, int n, int left, int right) {
  while (left < right){
    int mid = left + (right - left) / 2;
    if (isSolvable(arr, n, mid)) 
      right = mid;
    else 
      left = mid + 1;
  }
  return left;
}

//=================================================================

int main(){
  int n, totalSum = 0;
  assert(scanf("%d", &n) == 1);

  int *arr = safeMalloc(n * sizeof(int));
  
  for (int i = 0; i < n; ++i){ 
    assert(scanf("%d", &arr[i]) == 1);
    totalSum += arr[i];
  }
  
  printf("%d\n", binSearch(arr, n, 0, totalSum)); 
  
  free(arr);
  return 0; 
}