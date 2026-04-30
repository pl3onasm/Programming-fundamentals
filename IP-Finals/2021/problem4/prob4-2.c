/* file: prob4-2.c
   author: David De Potter
   version: 4.2, using an int function, getMaxSum
   description: IP Final 2021, problem 4, maximum sum
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Recursively computes the maximum sum of non-adjacent elements
int getMaxSum(int arr[], int idx, int sum, int len) {
  
    // base case
  if (idx < 0) 
    return len >= 2 ? sum : 0; 

    // recursive case: either take or skip arr[idx]
  int x = getMaxSum(arr, idx - 2, sum + arr[idx], len + 1); 
  int y = getMaxSum(arr, idx - 1, sum, len);              

  return x > y ? x : y;
}

//=================================================================

int main(){
  int arr[35], n; 
  assert(scanf("%d", &n) == 1);

  for(int i = 0; i < n; ++i)
    assert(scanf("%d", &arr[i]) == 1);

  printf("%d\n", getMaxSum(arr, n - 1, 0, 0));
  return 0; 
}

 