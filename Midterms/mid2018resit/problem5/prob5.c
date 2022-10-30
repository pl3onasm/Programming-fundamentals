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
  for (int a=1; a<=n-2;++a) 
    for (int b=a+1; b<=n-1; ++b){ 
      int c = n-a-b; 
      if (c > b && ((modExp(a,n,n) + modExp(b,n,n)) %n == modExp(c,n,n) %n)) 
        count++;
    }
  printf("%d\n", count);
  return 0;
}
