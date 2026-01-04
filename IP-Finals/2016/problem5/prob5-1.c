/* file: prob5-1.c
   author: David De Potter
   version: 5.1, using a void function and an int pointer to count
   description: IP Final 2016, problem 5, balanced subsequences
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Generates all subsequences of array a of given length, and
// counts how many have equal number of even and odd integers
// by updating count via a pointer
void generateSequences(int a[], int idx, int evens, int odds, 
                       int *count){

      // base case: all elements have been considered,
      // check if even and odd counts are equal
    if (idx < 0){ 
      if (evens == odds && evens > 0) 
        ++*count;
    return; 
  }

    // put the current element a[idx] into the sequence and
    // update the even/odd counts accordingly
  int odd = a[idx] % 2; 
  generateSequences(a, idx - 1, evens + !odd, odds + odd, count);

    // skip the current element a[idx]
  generateSequences(a, idx - 1, evens, odds, count);
}

//=================================================================
// Initiates the generation of subsequences and counting
int numberOfBalancedSubsets(int length, int a[]) {
  int count = 0;
  generateSequences(a, length - 1, 0, 0, &count); 
  return count; 
}

//=================================================================

int main() {
  int n, i, seq[20];

  assert(scanf ("%d", &n) == 1);

  for (i = 0; i < n; ++i) 
    assert(scanf("%d", &seq[i]) == 1);
  
  printf("%d\n", numberOfBalancedSubsets(n, seq));

  return 0;
}