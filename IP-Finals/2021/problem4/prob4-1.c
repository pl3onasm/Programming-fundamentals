/* file: prob4-1.c
   author: David De Potter
   version: 4.1, using a void function, computeSum, 
      and an int pointer to keep the maxixum sum
   description: IP Final 2021, problem 4, maximum sum
*/

#include <stdio.h>
#include <stdlib.h>

void computeSum(int arr[], int idx, int sum, int len, int *max) {
  if (idx < 0) {
    if (len > 1 && sum > *max) *max = sum;
    return; 
  } 
  computeSum(arr, idx-1, sum, len, max);              // skip
  computeSum(arr, idx-2, sum + arr[idx], len+1, max); // take
}

int main(int argc, char **argv){
  int arr[35], n, max=0; 
  (void)! scanf("%d", &n);
  for(int i = 0; i < n; i++)
    (void)! scanf("%d ", &arr[i]);
  computeSum(arr, n-1, 0, 0, &max);
  printf("%d\n", max);
  return 0; 
}
