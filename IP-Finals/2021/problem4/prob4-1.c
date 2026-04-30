/* file: prob4-1.c
   author: David De Potter
   version: 4.1, using a void function, computeSum, 
      and an int pointer to keep the maxixum sum
   description: IP Final 2021, problem 4, maximum sum
   complexity: Exponential. We explore all valid selections of
     non-adjacent elements via branching (take/skip).
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Recursively computes the maximum sum of non-adjacent elements
void computeSum(int arr[], int idx, int sum, int len, int *max) {
  
    // base case
  if (idx < 0) {
    if (len > 1 && sum > *max) *max = sum;
    return; 
  } 

    // recursive case: either take or skip arr[idx]
  computeSum(arr, idx - 1, sum, len, max);              
  computeSum(arr, idx - 2, sum + arr[idx], len + 1, max); 
}

//=================================================================

int main(){
  int arr[35], n, max=0; 
  assert(scanf("%d", &n) == 1);

  for(int i = 0; i < n; ++i)
    assert(scanf("%d", &arr[i]) == 1);
  
  computeSum(arr, n - 1, 0, 0, &max);
  printf("%d\n", max);

  return 0; 
}
