/* file: prob4.c
   author: David De Potter
   description: IP Final 2021, problem 4, maximum sum
*/

#include <stdio.h>
#include <stdlib.h>

void computeSum(int arr[], int n, int index, int sum, int len, int *max) {
  if (index >= n) {
    if (len > 1 && sum > *max) *max = sum;
    return; 
  } 
  computeSum(arr, n, index + 1, sum, len, max); // skip
  computeSum(arr, n, index + 2, sum + arr[index], len+1, max); // take
}

int main(int argc, char **argv){
  int arr[35], n, max=0; 
  scanf("%d", &n);
  for(int i = 0; i < n; i++)
    scanf("%d ", &arr[i]);
  computeSum(arr, n, 0, 0, 0, &max);
  printf("%d\n", max);
  return 0; 
}
