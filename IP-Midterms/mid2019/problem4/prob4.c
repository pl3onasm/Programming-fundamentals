/* file: prob4.c
   author: David De Potter
   description: IP mid2019, problem 4, Armstrong numbers
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
// Checks if n is an Armstrong number
int isArmstrongNumber (int n) {
  int digitSum = 0, p = n;
  int len = countDigits(n);
  for (int i = 0; i < len; ++i) {
    digitSum += power(p % 10, len);
    p /= 10;
  }
  return n == digitSum;
}

//=================================================================

int main() {
  int n, x, index = 0;
  assert(scanf("%d", &n) == 1);
  
  for (x = 1; ; ++x) {
    if (isArmstrongNumber(x)) ++index;
    if (index == n) break;
  }

  printf("%d\n", x);
  return 0;
}
