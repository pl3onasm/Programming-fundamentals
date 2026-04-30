/* file: prob2.c
  author: David De Potter
  description: IP mid2020, problem 2, Disarium numbers
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Computes n raised to the power exp using binary exponentiation
int power(int n, int exp) {
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n; 
    exp /= 2;
  }
  return pow;
}

//=================================================================
// Counts the number of digits in n
int countDigits (int n) {
  int count = 0;
  do {
    ++count;
    n /= 10;
  } while (n);
  return count;
}

//=================================================================

int main() {
  int n, idx = 0, digits[10];  // int has at most 10 digits
  assert(scanf("%d", &n) == 1);
  int len = countDigits(n);

    // Store digits from least significant 
    // to most significant
  int m = n;
  while (m) {
    digits[idx++] = m % 10;
    m /= 10;
  }

    // Walk from most significant to least significant digit;
    // digits[len-1] is the most significant digit
  int sum = 0;
  for (int pos = 1; pos <= len; ++pos) {
    int digit = digits[len - pos];  
    sum += power(digit, pos);
  }

  printf(n == sum ? "YES\n" : "NO\n");
  return 0;
}