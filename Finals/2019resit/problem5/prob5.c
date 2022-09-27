/* file: prob5.c
   author: David De Potter
   description: IP Final 2019 resit, problem 5, 
   sum of subsets
*/

#include <stdio.h>
#include <stdlib.h>

int computeSubsetSum(int arr[], int index, int sum){
  if (index < 0) return sum;
  return computeSubsetSum(arr, index-1, sum) 
    + computeSubsetSum(arr, index-1, sum+arr[index]);
}

int main(int argc, char **argv){
  int arr[20], n;
  for (int i=0; i<20; ++i) arr[i]=i+1;
  scanf("%d ", &n);
  printf("%d\n", computeSubsetSum(arr, n-1, 0));
  return 0; 
}