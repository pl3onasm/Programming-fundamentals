/* file: prob3-1.c
   author: David De Potter
   description: IP Final 2018 Resit, problem 3, ordered pairs
   version: 3.1, sloooooooooow version

   We want to find the number of inversions in the array. 
   A possible solution is to use bubble sort and count the number 
   of swaps that are needed. This is, however, slow, since bubble 
   sort is slow (O(n²)). You'll see that the program takes a long 
   time to run on test cases 9 and 10. 
   
   A better solution is to sort the array with mergesort, and count 
   the number of inversions while merging. This approach gives a 
   solution in O(nlogn), which is much faster.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory and checks for allocation errors
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    fprintf(stderr, "Error: malloc(%zu) failed. "
                    "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Reads an integer vector from standard input
int *readIntVector (int size) {
  int *vect = safeMalloc(size * sizeof(int));
  for (int i = 0; i < size; ++i)
    assert(scanf("%d", vect + i) == 1);
  return vect;
}

//=================================================================
// Swaps two integers
void swap (int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp; 
}

//=================================================================
// Counts the number of swaps needed to bubble sort arr;
// this is exactly the number of ordered pairs (i,j) such that
// a[i] > a[j] and i < j
int bubbleCount(int *arr, int len) {
  int i, j, change, count=0;
  for (i = 0; i < len; ++i) {
    change = 0;
    for (j = 0; j < len - i - 1; ++j) {
      if (arr[j] > arr[j + 1]) {
        swap(&arr[j], &arr[j + 1]);
        change = 1;
        ++count; 
      }
    }
    if (!change) break;
  }
  return count;
}

//=================================================================

int main(){
  int size; 
  assert(scanf("%d\n", &size) == 1);

  int *vect = readIntVector(size); 

  printf("%d\n", bubbleCount(vect, size));

  free(vect); 
  return 0; 
}