/* 
  file: prob2.c
  author: David De Potter
  description: 3-3rd resit exam 2024, problem 2,
    special numbers
*/

#include <stdio.h>
#include <stdlib.h>

int isSpecial(int n) {
  // determines if n is a special number
  int count = 0;
  // check number of prime factors up to sqrt(n)
  for (int i = 2; i * i <= n; i += (i == 2) ? 1 : 2) {
    while (n % i == 0) {
      n /= i;     
      if (++count > 1) 
        return 0;
    }
  }
  return count;  // 0 if prime, 1 if special
}

int main(){
  int m, count = 0, a = 0, b = 0, c = 0;

  (void)! scanf("%d", &m);

  // we check for n, n - 1 and n - 2 for efficiency
  // so we start at n = 3 and go up to m + 1
  for (int n = 3; n < m + 2; ++n) {
    c = b;
    b = a;
    a = isSpecial(n);

    if (a && b && c) 
      ++count;
  } 

  printf("%d\n", count);
  return 0;
}

