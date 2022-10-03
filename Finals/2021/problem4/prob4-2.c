/* file: prob4-2.c
   author: David De Potter
   description: IP Final 2021, problem 4, maximum sum
   this version prints all the sums and the terms that were considered
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void printArray(int array[], int size){
  for(int i = 0; i< size; i++){
    printf("%i", array[i]);
    if (i < size-1) printf(" + "); 
  }
}

void computeSum(int arr[], int n, int index, int sum, int len, int *max, int res[]) {
  if (index >= n) {
    if (len > 1) {
      printArray(res, len);
      printf(" = %d\n", sum); 
      if (sum > *max) *max = sum;
    }
    return; 
  } 
  computeSum(arr, n, index + 1, sum, len, max, res);
  res[len] = arr[index];
  computeSum(arr, n, index + 2, sum + arr[index], len+1, max, res);
}

int main(int argc, char **argv){
  int arr[35], n, max=0, res[35]; 
  scanf("%d", &n);
  for(int i = 0; i < n; i++)
    scanf("%d ", &arr[i]);
  computeSum(arr, n, 0, 0, 0, &max, res);
  printf("max: %d\n", max);
  return 0; 
}
