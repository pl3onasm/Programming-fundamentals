/* file: doublepalin.c
* author: David De Potter
* description: problem 2, double palindromes, mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int toBinary (int n, char bin[25]) {
  /* computes the binary representation of n */
  int i = 0;
  while (n > 0) {
    bin[i] = n%2 + '0';
    n /= 2; i++;
  }
  return i; // number of digits in binary
}

int isDecPalin(int n) {
  int rev = 0, m = n;
  while (m > 0) {
    rev = rev * 10 + m % 10;
    m /= 10;
  }
  return rev == n;
}

int isBinPalin(char bin[25], int len) {
  int i = 0;
  while (i < len/2) {
    if (bin[i] != bin[len-i-1]) return 0;
    i++;
  }
  return 1;
}

int main(int argc, char *argv[]) {
  int a, b, count=0; char bin[25];
  scanf("%d %d", &a, &b);
  for (int n = a; n <= b; ++n) {
    int binsize = toBinary(n, bin);
    if (isDecPalin(n) && isBinPalin(bin, binsize)) 
      count++;
  }
  printf("%d\n", count);
  return 0;
}