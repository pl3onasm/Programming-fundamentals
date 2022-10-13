/* file: prob5.c
* author: David De Potter
* description: problem 5, modular Fermat, resit mid2018
*/

#include <stdio.h>
#include <stdlib.h>

int modExp (int a, int b, int n) {
  // computes a^b mod n using modular exponentiation 
  int r = 1;
  while (b > 0) {
    if (b % 2) r = (r * a) % n;
    a = (a * a) % n;
    b /= 2;
  }
  return r;
}

int main(int argc, char *argv[]) {
  int n, count=0;
  scanf ("%d", &n);
  for (int i=1; i<=n-2;++i) 
    for (int j=i+1; j<=n-1; ++j) 
      for (int k=j+1; k<=n; ++k) 
        if ((i+j+k == n) && ((modExp(i,n,n)+modExp(j,n,n))%n == modExp(k,n,n)%n)) 
          count++;
  printf("%d\n", count);
  return 0;
}
