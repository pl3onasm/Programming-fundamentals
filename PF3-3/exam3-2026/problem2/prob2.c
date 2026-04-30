/* 
  file: prob2.c
  author: David De Potter
  description: 3-3rd exam 2026, problem 2, Primonacci
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Checks whether n is prime
int isPrime (int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//===================================================================

int main() {
  int n, c;
  assert(scanf ("%d", &n) == 1);

  if (n <= 1) {
    printf ("%d\n", n);
    return 0;
  }

  int a = 0;    // f(0)
  int b = 1;    // f(1)

  for (int i = 2; i <= n; ++i) {
    if (isPrime(i))
      c = (a + b) % 2026;
    else
      c = (1 + b) % 2026;

    a = b;
    b = c;
  }

  printf ("%d\n", c);
  
  return 0;
}

