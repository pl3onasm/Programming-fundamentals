/* file: prob5.c
   author: David De Potter
   description: PF 1/3rd term 2025, problem 5,
                descriptive numbers
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// reads input integer array and returns the number of digits read
int readInput(int *runs) {
  int c, i = 0;
  while ((c = getchar()) != ' ' && c != EOF) 
    runs[i++] = c - '0';
  return i;
}

//===================================================================
// stores the decimal representation of n in the array runs at 
// position idx
void storeCount(int n, int *runs, int *idx) {
  int rev[10], j = 0;
  do {
    rev[j++] = n % 10;
    n /= 10;
  } while (n > 0);

    // append in reverse order
  for (int i = j - 1; i >= 0; --i) 
    runs[(*idx)++] = rev[i];
}

//===================================================================
// computes the next run-length encoding of the input array
void computeRuns(int *runs, int *len) {
  int count = 1, j = 0, newruns[965];

  for (int i = 1; i < *len; ++i) {
    if (runs[i] == runs[i-1]) 
      count++;
    else {
      storeCount(count, newruns, &j);
      newruns[j++] = runs[i-1];
      count = 1;
    }
  }
    // flush the last run
  storeCount(count, newruns, &j);
  newruns[j++] = runs[*len - 1];
  
    // copy back to runs
  for (int i = 0; i < j; ++i) 
    runs[i] = newruns[i];

  *len = j;
}  


//===================================================================

int main() {
  int s, runs[965];
  int len = readInput(runs);
  assert(scanf(" %d", &s) == 1);

    // compute s successive run-length encodings
  for (int i = 0; i < s; ++i)  
    computeRuns(runs, &len);
  
    // print the resulting array
  for (int i = 0; i < len; ++i)
    printf("%d", runs[i]);
  printf("\n");

  return 0;
}