/* file: prob3.c
   author: David De Potter
   description: problem 3, takuzu numbers, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Returns 1 if n has an even bit-length (ignoring leading 0-bits)
int hasEvenBitLength(int n) {
  int len = 0;
  while (n) {
    ++len;
    n >>= 1;
  }
  return (len % 2 == 0);
}

//=================================================================
// Checks if n meets the Takuzu criteria
int checkIfTakuzu (int n) {

    // Filter: takuzu numbers must have an even bit-length
  if (!hasEvenBitLength(n))
    return 0;

  int count0 = 0, count1 = 0; 
  int countAdj1 = 0, countAdj0 = 0;

  while (n) {
    if (n & 1) {
      count1++;
      countAdj1++;
      countAdj0 = 0;
    } else {
      count0++;
      countAdj1 = 0;
      countAdj0++;
    }
    if (countAdj1 > 2 || countAdj0 > 2) return 0;
    n >>= 1;
  }

  return count1 == count0;
}

//=================================================================

int main() {
  int n, index = 0, number = 1;

  assert(scanf("%d", &n) == 1);
  
  while (index != n) {
    ++number;
    if (checkIfTakuzu(number))
      ++index;
  }

  printf("%d\n", number);
  return 0;
}
