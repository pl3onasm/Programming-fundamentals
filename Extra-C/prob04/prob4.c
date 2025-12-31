/* file: prob4.c
   author: David De Potter
   description: extra, problem 4, binary palindromes

   Approach:
    We need to print all integers p in [a, b] such that:
      (1) the binary representation of p (without leading zeros) 
          is a palindrome
      (2) p has an odd number of 1 bits

    Brute-forcing all p in [a, b] and checking these properties 
    would be too slow. Instead, we generate binary palindromes 
    directly.

    A binary palindrome of bit-length L is determined by its 
    left half:
      - If L is odd (L = 2m - 1), choose m bits (with leading 
        bit 1) and mirror the first (m-1) bits to the right 
        (excluding the middle bit).
      - If L is even (L = 2m), choose m bits (with leading bit 1) 
        and mirror all m bits to the right.

    We iterate over all possible bit-lengths L (1..31, since
    b < 2^31), and for each L we enumerate all possible left
    halves in increasing order. This generates palindromes in 
    ascending numeric order, so no sorting is needed. We then 
    filter by [a, b] and odd number of 1 bits.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef unsigned int uint;

//=================================================================
// Returns 1 if n has an odd number of 1 bits, 0 otherwise.
int hasOddOnes(uint n) {
  int parity = 0;
  while (n) {
    parity ^= (n & 1u);     // XOR with least significant bit
    n >>= 1;                // shift right by 1
  }
  return parity;
}

//=================================================================
// Prints the binary representation of n (msb first). We first 
// locate the most significant 1-bit, then print down to bit 0.
void printBinary(uint n) {
  int msb = 31;
    // find position of most significant 1-bit
  while (msb > 0 && ((n >> msb) & 1u) == 0)
    --msb;

    // print bits from msb down to 0
  for (int k = msb; k >= 0; --k)
    printf("%c", ((n >> k) & 1u) ? '1' : '0');

  printf("\n");
}

//=================================================================
// Builds a binary palindrome from its left half. If exclMid is 1, 
// we mirror half excluding its least significant bit.
// If exclMid is 0, we mirror all bits of half.
uint makePalindrome(uint half, int exclMid) {
  uint p = half;
  uint x = exclMid ? (half >> 1) : half;

  while (x) {
    p = (p << 1) | (x & 1u);
    x >>= 1;
  }
  return p;
}

//=================================================================
// Enumerates all palindromes of a fixed bit-length L (1..31) and 
// prints those in [a, b] having an odd number of 1 bits. 
// Returns 1 if at least one palindrome was printed, 0 otherwise.
int processLength(int L, uint a, uint b) {

    // Determine half-length m and whether we exclude the middle 
    // bit during mirroring.
  int oddLen  = (L % 2 == 1);
  int exclMid = oddLen;               // odd length excludes middle
  int m       = oddLen ? (L + 1) / 2
                       :  L / 2;

  uint start = 1u << (m - 1);         // ensure leading bit 1
  uint end   = (1u << m) - 1;         // largest m-bit value

  int found = 0;

  for (uint half = start; half <= end; ++half) {
    uint p = makePalindrome(half, exclMid);

      // filter by [a, b] and odd number of 1s
    if (p < a) continue;
    if (p > b) break;

    if (hasOddOnes(p)) {
      found = 1;
      printf("%u: ", p);
      printBinary(p);
    }
  }

  return found;
}

//=================================================================
// Generates all binary palindromes p in [a, b] with an odd number 
// of 1s. Prints them in ascending order as: "decimal: binary".
void generatePalindromes(uint a, uint b) {
  int found = 0;

    // L is the bit-length of the palindrome 
    // Ranges from 1..31 since b < 2^31)
  for (int L = 1; L <= 31; ++L)
    found |= processLength(L, a, b);

  if (!found)
    printf("0\n");
}

//=================================================================

int main() {
  uint a, b;
  assert(scanf("%u %u", &a, &b) == 2);

  generatePalindromes(a, b);

  return 0;
}
