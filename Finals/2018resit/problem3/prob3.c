/* file: prob3.c
   author: David De Potter
   description: IP Final 2018 Resit, problem 3, ordered pairs
   version: 1.0, slow version
   We want to find the number of inversions in the array. A possible
   solution is to use bubble sort and count the number of swaps that 
   are needed. This is, however, slow, since bubble sort is slow (O(n²)). 
   Another solution is to sort the array with mergesort, which gives
   a solution in O(nlogn).  
*/

#include <stdio.h>
#include <stdlib.h>

int *readIntVector (int size) {
  int *vect = malloc(size * sizeof(int));
  for (int i = 0; i < size; i++)
    scanf("%d", vect + i);
  return vect;
}

void swap (int *arr, int i, int j) {
  int h = arr[i];
  arr[i] = arr[j];
  arr[j] = h;
}

int bubbleCount(int *arr, int len) {
  /* counts the number of swaps needed to bubble sort arr;
    this is exactly the number of ordered pairs (i,j)
    such that a[i] > a[j] */
  int i, j, change, count=0;
  for (i=0; i < len; ++i) {
    change=0;
    for (j=0; j+1 < len - i; ++j) {
      if (arr[j] > arr[j+1]) {
        swap(arr, j, j+1);
        change = 1;
        ++count; 
      }
    }
    if (change == 0) break;
  }
  return count;
}

int main(int argc, char **argv){
  int size; 
  scanf("%d\n", &size);
  int *vect = readIntVector(size); 
  printf("%d\n", bubbleCount(vect, size));
  free(vect); 
  return 0; 
}