/* file: prob5-3.c
   author: David De Potter
   version: 5.3, using an int function
   description: IP Final 2016, problem 5, balanced subsequences
*/

#include <stdio.h>
#include <stdlib.h>

int countSequences(int a[], int idx, int evens, int odds){
  // base case: check if balanced
  if (idx < 0) return evens && evens == odds;
  // recursive case: put a[idx] into the sequence or skip it
  return countSequences(a, idx-1, evens + !(a[idx]%2), odds + a[idx]%2)
       + countSequences(a, idx-1, evens, odds);
}

int numberOfBalancedSubsets(int length, int a[]) {
  return countSequences(a, length-1, 0, 0); 
}

int main(int argc, char *argv[]) {
  int n, i, seq[20];
  (void)! scanf ("%d\n", &n);
  for (i=0; i < n; i++) {
    (void)! scanf("%d", &seq[i]);
  }
  printf("%d\n", numberOfBalancedSubsets(n, seq));
  return 0;
}