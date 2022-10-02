/* file: fermat.c
* author: David De Potter
* description: problem 5, modular Fermat, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int modExp (int a, int p) {
  /*Computes (a^p)mod p using modular exponentiation*/
  long m=1, exp;
  exp = p;
  while (exp != 0) {
    if (exp % 2 == 0) {
      a *= a;
      if (a > p) a = a % p;
      exp = exp / 2;
    } else {
      m *= a;
      if (m > p) m = m % p;
      exp--;
    }
  }
  return m % p;
}

int modExpSum (int a, int b, int p) {
  /*Computes (a^p + b^p)mod p using modular exponentiation*/
  long m=1, n=1, exp;
  exp = p;
  while (exp != 0) {
    if (exp % 2 == 0) {
      a *= a;
      b *= b;
      if (a + b > p) {
        a = a % p;
        b = b % p;
      }
      exp = exp / 2;
    } else {
      m *= a;
      n *= b;
      if (m + n > p) {
        m = m % p;
        n = n % p;
      }
      exp--;
    }
  }
  return (m+n) % p;
}

int main(int argc, char *argv[]) {
  int n, count=0;
  scanf ("%d", &n);
  for (int i=1; i<=n-2;++i) 
    for (int j=i+1; j<=n-1; ++j) 
      for (int k=j+1; k<=n; ++k) 
        if ((i+j+k == n) && (modExpSum(i,j,n) == modExp(k,n))) 
          count++;
  printf("%d\n", count);
  return 0;
}
