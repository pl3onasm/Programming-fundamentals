/* file: prob4.c
   author: David De Potter
   description: PF 1/3rd resit 2026, problem 4, 
                Removing extrema
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// Performs one reduction step by marking all extrema as -1.
// Returns 1 if any elements were marked, 0 otherwise.
int stabilize(int arr[], int n) {
  int a = -1, b = -1, c = -1;
  int prev = -1, changed = 0;

  for (int i = 0; i < n; ++i) {
      // skip elements that have been removed
    if (arr[i] == -1) continue;

    c = b;
    b = a;
    a = arr[i];
    
      // check b only when three real elements have been read
    if (c != -1 && ((b < a && b < c) || (b > a && b > c))) {
      arr[prev] = -1;
      changed = 1;
    }
      // remember the index of a, which becomes b
      // when the next unmarked element is read
    prev = i;
  }

  return changed;
}


//===================================================================

int main() {
  int n, arr[1000] = {0};
    
    // read the number of elements and the elements themselves
  int count = scanf("%d", &n);
  assert(count == 1);
  for (int i = 0; i < n; ++i) {
    count = scanf("%d", &arr[i]);
    assert(count == 1);
  }
    
    // repeat reduction steps until no extrema remain
  while (stabilize(arr, n));
  
    // print the stabilized array
  printf("[");
  for (int i = 0; i < n; ++i) 
    if (arr[i] != -1) 
      printf(i < n-1 ? "%d," : "%d]\n", arr[i]); 

  return 0;
}