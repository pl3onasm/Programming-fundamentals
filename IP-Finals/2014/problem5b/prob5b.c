/* file: prob4b.c
   author: David De Potter
   description: IP Final 2014, problem 5b, 
   Recursive algorithms, kth smallest element
*/

#include <stdio.h>
#include <stdlib.h>

void swap(int *a, int *b) {
  int temp = *a; 
  *a = *b; 
  *b = temp;
}

int partition(int *arr, int len) {
  int idx=0, pivot = arr[0];
  swap(&arr[len-1], &arr[0]);
  for (int i = 0; i < len-1; i++)
    if (arr[i] < pivot){
      swap(&arr[i], &arr[idx]);
      idx++;
    }
  swap(&arr[len-1], &arr[idx]);
  return idx;
}

int kthSmallest(int k, int len, int *arr) {
  if (len == 1) 
    return arr[0];
  int p = partition(arr, len);
  if (p == k) return arr[p];
  if (p < k) return kthSmallest(k-p-1, len-p-1, arr+p+1);
  return kthSmallest(k, p, arr);
}

int main(int argc, char *argv[]) {
  int n, k, arr[100], len=0;
  (void)! scanf("%d", &k);
  while (scanf("%d", &n) == 1) 
    arr[len++] = n;
  printf("%d\n", kthSmallest(k, len, arr));
  return 0;
}