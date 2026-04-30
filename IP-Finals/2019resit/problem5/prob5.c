/* file: prob5.c
   author: David De Potter
   description: IP Final 2019 resit, problem 5, 
   sum of subsets
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes the sum of all subset sums of arr[0..index]
int computeSubsetSum(int arr[], int idx, int sum){

    // base case: no more elements to consider
  if (idx < 0) 
    return sum;

    // recursive case: include or exclude arr[index]
  return computeSubsetSum(arr, idx - 1, sum) 
       + computeSubsetSum(arr, idx - 1, sum + arr[idx]);
}

//=================================================================

int main(){
  int arr[20], n;
    // initialize array with values 1..20
  for (int i = 0; i < 20; ++i) 
    arr[i] = i + 1;
  
  assert(scanf("%d", &n) == 1);

  printf("%d\n", computeSubsetSum(arr, n - 1, 0));
  return 0; 
}