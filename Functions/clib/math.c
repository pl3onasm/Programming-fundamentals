#include "clib.h"

  // returns 1 if x is prime, 0 otherwise
int isPrime(int x) {
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2) 
    if (x % i == 0) return 0;
  return 1;
}

  // returns 1 if n is a perfect square, 0 otherwise
int isPerfSquare(int n) {
  int root = sqrt(n);
  return root * root == n;
}

  // checks whether y evenly divides x
int isDivisor(int x, int y) {
  return x % y == 0;
}

  // returns the greatest common divisor of a and b
int GCD(int a, int b) {
  if (b == 0) return a;
  return GCD(b, a % b);
}

  // returns the least common multiple of a and b
int LCM(int a, int b) {
  return a / GCD(a, b) * b;
}

  // returns 1 if a and b are coprime, 0 otherwise
  // a and b are coprime if they have no common factors
int areCoprime(int a, int b) {
  return GCD(a, b) == 1;
}

  // returns n^exp using binary exponentiation 
  // also known as exponentiation by squaring
  // see note below
int power(int n, int exp) {
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n;
    exp /= 2;
  }
  return pow;
}

  // computes n^exp mod m using modular exponentiation 
  // see note below
int modExp(int n, int exp, int m) {
  int pow = 1; n %= m;
  while (exp) {
    if (exp & 1) pow = (pow * n) % m;
    if (exp > 1) n = (n * n) % m;
    exp /= 2;
  }
  return pow;
}


/* NOTE

  Both power and modExp use the method of exponentiation 
  by squaring, which works in O(log(exp)) time instead of
  O(exp) time for the naive method of repeated 
  multiplication.
  The idea is that instead of multiplying n by itself exp 
  times, we can reduce the number of multiplications by 
  taking advantage of the fact that n^exp = (n^2)^(exp/2) 
  if exp is even. If exp is odd (exp & 1 is true), we 
  simply make the exponent even by taking one n out: 
  n^exp = n * n^(exp-1), so that we can then apply the 
  same rule as in the even case.
  Explicitly decrementing the exponent in the odd case is
  not necessary, however, since the integer division by 2 
  at the end of the loop will take care of it: if exp is 
  odd (say exp = 2k + 1 for some integer k) then exp/2 = k, 
  and (exp-1)/2 = k as well. Thus, whether we explicitly 
  decrement exp in the odd case or not, after the division 
  by 2 we will end up with exp = k regardless.
  The check for exp > 1 is just an optimization to avoid
  an unnecessary multiplication when exp == 1.

*/