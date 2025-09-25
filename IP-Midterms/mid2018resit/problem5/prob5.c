/* file: prob5.c
* author: David De Potter
* description: problem 5, modular Fermat, resit mid2018
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
  int n, count=0;

  (void)! scanf ("%d", &n);

  for (int a = 1; a <= n - 2; ++a) 
    for (int b = a + 1; b <= n - 1; ++b){ 
      int c = n - a - b; 
      if (c > b && ((modExp(a,n,n) 
          + modExp(b,n,n)) % n == modExp(c,n,n) % n)) 
        count++;
    }
    
  printf("%d\n", count);
  return 0;
}
