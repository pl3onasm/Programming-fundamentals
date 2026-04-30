/* file: prob1.c
   author: David De Potter
   description: problem 1, 9's complement
   subtraction, resit mid2016
*/

#include <stdio.h>
#include <stdlib.h> 
#include <assert.h>

//=================================================================
// Computes n to the power of exp using binary exponentiation
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

int main () {
  int p, c, a, b;

  assert(scanf ("%d %d", &a, &b) == 2);

  p = power(10, countDigits(a)) - 1;
  c = p - a;

  printf("%d-%d=", a, b);
  printf("%d-((%d-%d)+%d)=", p, p, a, b);
  printf("%d-(%d+%d)=", p, c, b);
  printf("%d-%d=", p, b + c);
  printf("%d\n", p - (b + c));

  return 0;
}
