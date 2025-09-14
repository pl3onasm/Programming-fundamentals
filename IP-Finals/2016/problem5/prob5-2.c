/* file: prob5-1.c
   author: David De Potter
   version: 5.2, more concise version of 5.1
   description: IP Final 2016, problem 5, balanced subsequences
*/

#include <stdio.h>
#include <stdlib.h>

void generateSequences(int a[], int idx, int evens, int odds, int *count){
  if (idx < 0){  // base case
    if (evens && evens == odds) ++*count;
    return; 
  }
  // put the current element a[idx] into the sequence
  generateSequences(a, idx-1, evens + !(a[idx]%2), odds + a[idx]%2, count);
  // skip the current element
  generateSequences(a, idx-1, evens, odds, count);
}

int numberOfBalancedSubsets(int length, int a[]) {
  int count = 0;
  generateSequences(a, length-1, 0, 0, &count); 
  return count; 
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