/* file: prob4.c
* author: David De Potter
* description: problem 4, PDS numbers, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  /* determines if x is prime or not */
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

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

int replaceDigits (int p) {
  /* replaces each digit d of p with the
   * remainder of division of d^2 by 10 */
  int count = 0, result=0, sqdigit;
  while (p != 0) {
    sqdigit = (p % 10)*(p % 10);
    p /= 10;
    result += (sqdigit % 10)*power(10,count);
    count++;
  }
  return result;
}

int isPDS (int n) {
  /* Checks if n is a Primal Digit Square number */
  int prev;
  while (isPrime(n)) {
    prev = replaceDigits(n);
    if (n == prev) return 1;
    n = prev;
  }
  return 0; //at least one number was not prime
}

int main (int argc, char *argv[]) {
  int a, b, count=0;

  (void)! scanf ("%d %d", &a, &b);

  for (int n=a; n <= b; ++n) 
    if (isPDS(n)) count++;
     //counts the number of PDS numbers between a and b
     
  printf("%d\n", count);
  return 0;
}
