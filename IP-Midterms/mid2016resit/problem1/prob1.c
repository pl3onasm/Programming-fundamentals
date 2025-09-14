/* file: prob1.c
* author: David De Potter
* description: problem 1, 9's complement
* subtraction, resit mid2016
*/

#include <stdio.h>
#include <stdlib.h>

int power(int n, int exp) {
  // returns n^exp using binary exponentiation
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n; 
    exp /= 2;
  }
  return pow;
}

int countDigits (int n) {
  int count = 0;
  while (n) {
    count++; 
    n /= 10;
  }
  return count;
}

int complement (int x) {
  return (power(10, countDigits(x)) -1 - x);
}

int main (int argc, char *argv[]) {
  int p, c, a, b;
  
  (void)! scanf ("%d %d", &a, &b);
  
  p = power(10, countDigits(a)) - 1;
  c = complement(a);
  
  printf("%d-%d=", a, b);
  printf("%d-((%d-%d)+%d)=", p, p, a, b);
  printf("%d-(%d+%d)=", p, c, b);
  printf("%d-%d=", p, b+c);
  printf("%d\n", complement(b+c));

  return 0;
}
