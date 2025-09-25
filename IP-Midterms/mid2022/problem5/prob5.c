/* file: prob5.c
   author: David De Potter
   description: IP mid2022, problem 5, Curzon numbers
   We use modular exponentiation and rewrite the condition as
       (2ⁿ + 1) mod (2*n + 1) = 0
    ⇔ (2ⁿ mod (2*n + 1) + 1 mod (2*n + 1)) mod (2*n + 1) = 0
    ⇔ (2ⁿ mod (2*n + 1) + 1) mod (2*n + 1) = 0
*/

#include <stdio.h>
#include <stdlib.h>

int modExp (int n, int exp, int m) {
  /* computes n^exp mod m using modular exponentiation */
  int pow = 1; n %= m;
  while (exp) {
    if (exp & 1) pow = (pow * n) % m;
    if (exp > 1) n = (n * n) % m;
    exp /= 2;
  }
  return pow;
}

int main(int argc, char *argv[]) {
  int n; 
  (void)! scanf("%d", &n);
  
  printf((modExp(2,n,2*n+1) + 1) % (2*n + 1) ? "NO\n" : "YES\n");
  return 0;
}