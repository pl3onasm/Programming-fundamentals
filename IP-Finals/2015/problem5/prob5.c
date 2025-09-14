/* file: prob5.c
   author: David De Potter
   description: IP Final 2015, problem 5, ordered bit strings
   using recursion
*/

#include <stdio.h>
#include <stdlib.h>

void generateBitStrings(int length, int bitStrings[], int index, 
  int count0, int count1) {
  // base case: all bits have been set
  if (index >= length) {
    if (count0 == count1) {
      for (int i = 0; i < length; ++i) 
        printf("%d", bitStrings[i]);
      printf("\n");
    }
    return; 
  }
  // recursive case: set next bit
  bitStrings[index] = 0;   // we want dictionary order so we set 0 first
  generateBitStrings(length, bitStrings, index+1, count0+1, count1);
  if (count0 > count1){
    bitStrings[index] = 1;
    generateBitStrings(length, bitStrings, index+1, count0, count1+1);
  }
}

void showBitStrings(int n) {
  int bitStrings[20]={0};
  // we start with first bit set to 0, so 
  // count0 = 1 and start index = 1
  generateBitStrings(2*n, bitStrings, 1, 1, 0);
}

int main() {
  int n;
  (void)! scanf ("%d", &n); /* note: it is guaranteed that 0<n<=10 */
  showBitStrings(n);
  return 0;
}