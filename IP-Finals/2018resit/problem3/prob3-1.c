/* file: prob3-1.c
   author: David De Potter
   description: IP Final 2018 Resit, problem 3, ordered pairs
   version: 3.1, sloooooooooow version

   We want to find the number of inversions in the array. A possible
   solution is to use bubble sort and count the number of swaps that 
   are needed. This is, however, slow, since bubble sort is slow (O(n²)).
   You'll see that the program takes a long time to run on test cases 
   9 and 10. 
   
   A better solution is to sort the array with mergesort, and count the
   number of inversions while merging. This approach gives a solution 
   in O(nlogn), which is much faster.
*/

#include <stdio.h>
#include <stdlib.h>

void *safeMalloc (int n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

int *readIntVector (int size) {
  int *vect = safeMalloc(size * sizeof(int));
  for (int i = 0; i < size; i++)
    (void)! scanf("%d", vect + i);
  return vect;
}

void swap (int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp; 
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
        swap(&arr[j], &arr[j+1]);
        change = 1;
        ++count; 
      }
    }
    if (!change) break;
  }
  return count;
}

int main(int argc, char **argv){
  int size; 
  (void)! scanf("%d\n", &size);
  int *vect = readIntVector(size); 
  printf("%d\n", bubbleCount(vect, size));
  free(vect); 
  return 0; 
}