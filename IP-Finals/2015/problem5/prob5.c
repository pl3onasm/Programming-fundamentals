/* file: prob5.c
   author: David De Potter
   description: IP Final 2015, problem 5, ordered bit strings
   using recursion
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Generates and prints all bit strings of length 2n with
// equal number of 0s and 1s, in dictionary order
void generateBitStrs(int length, int bitStrs[], int idx, 
                     int cnt0, int cnt1) {

    // Base case: all bits have been set
  if (idx >= length) {
    if (cnt0 == cnt1) {
      for (int i = 0; i < length; ++i) 
        printf("%d", bitStrs[i]);
      printf("\n");
    }
    return; 
  }

    // Recursive case: set next bit to 0 or 1.
    // Start with 0 for dictionary order
  if (cnt0 < length / 2) {
    bitStrs[idx] = 0;   
    generateBitStrs(length, bitStrs, idx + 1, cnt0 + 1, cnt1); 
  }

  if (cnt1 < length / 2 && cnt0 > cnt1){
    // Can only set next bit to 1 if there are more 0s than 1s
    bitStrs[idx] = 1;
    generateBitStrs(length, bitStrs, idx + 1, cnt0, cnt1 + 1);
  }
}

//=================================================================
// Initiates the generation and printing of bit strings
void showBitStrings(int n) {
  int bitStrs[20] = {0};
    // We start with first bit set to 0, so 
    // count0 = 1 and start index = 1
  generateBitStrs(2 * n, bitStrs, 1, 1, 0);
}

//=================================================================

int main() {
  int n;
  
  assert(scanf ("%d", &n) == 1); 
  
  showBitStrings(n);
  
  return 0;
}