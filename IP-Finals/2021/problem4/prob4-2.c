/* file: prob4-2.c
   author: David De Potter
   version: 4.2, using an int function, getMaxSum
   description: IP Final 2021, problem 4, maximum sum
*/

#include <stdio.h>
#include <stdlib.h>

int getMaxSum(int arr[], int idx, int sum, int len) {
  // get maximum sum of subsequences with len >= 2
  if (idx < 0) return len >= 2 ? sum : 0; 
  int x = getMaxSum(arr, idx - 2, sum + arr[idx], len+1); // take
  int y = getMaxSum(arr, idx - 1, sum, len);              // skip
  return x > y ? x : y;
}

int main(int argc, char **argv){
  int arr[35], n; 
  (void)! scanf("%d", &n);
  for(int i = 0; i < n; i++)
    (void)! scanf("%d ", &arr[i]);
  printf("%d\n", getMaxSum(arr, n-1, 0, 0));
  return 0; 
}

 