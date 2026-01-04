/* file: prob5-3.c
   author: David De Potter
   version: 5.3, using an int function
   description: IP Final 2016, problem 5, balanced subsequences
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Counts the number of balanced subsequences
int countSequences(int a[], int idx, int evens, int odds){

    // base case: check if balanced
  if (idx < 0) 
    return evens == odds && evens > 0;

    // recursive case: put a[idx] into the sequence or skip it
  int up = a[idx] % 2;
  return countSequences(a, idx - 1, evens + !up, odds + up)
       + countSequences(a, idx - 1, evens, odds);
}

//=================================================================
// Initiates the generation of subsequences and counting
int numberOfBalancedSubsets(int length, int a[]) {
  return countSequences(a, length - 1, 0, 0); 
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