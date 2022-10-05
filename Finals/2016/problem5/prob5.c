/* file: prob5.c
   author: David De Potter
   description: IP Final 2016, problem 5, 
   balanced subsequences
*/

#include <stdio.h>
#include <stdlib.h>

void generateSequences(int a[], int n, int index, int evens, int odds, int *count){
  if (index == n){  // base case
    if (evens && evens == odds) (*count)++;
    return; 
  }
  // take the current element a[index] into the sequence
  if (a[index] % 2) generateSequences(a, n, index+1, evens, odds+1, count);
  else generateSequences(a, n, index+1, evens+1, odds, count);
  // skip the current element
  generateSequences(a, n, index+1, evens, odds, count);
}

int numberOfBalancedSubsets(int length, int a[]) {
  int count = 0;
  generateSequences(a, length, 0, 0, 0, &count); 
  return count; 
}

int main(int argc, char *argv[]) {
  int n, i, seq[20];
  scanf ("%d\n", &n);
  for (i=0; i < n; i++) {
    scanf("%d", &seq[i]);
  }
  printf("%d\n", numberOfBalancedSubsets(n, seq));
  return 0;
}