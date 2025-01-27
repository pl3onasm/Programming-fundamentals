/* 
  file: prob2.c
  author: David De Potter
  description: 3-3rd exam 2025, problem 2,
    semiprime triplets
*/

#include <stdio.h>
#include <stdlib.h>

//===================================================================
// Determines if n is semiprime
int isSemiprime(int n) {
  int count = 0, m = n;
    // checks number of prime factors up to sqrt(n)
  for (int i = 2; i * i <= m; i += (i == 2) ? 1 : 2) {
    while (m % i == 0) {
      m /= i;     
      if (++count > 1) 
        return i * i == n;  // 1 if semiprime, 0 if not
    }
  }
  return count;  // 0 if prime, 1 if semiprime
}

//===================================================================

int main(){
  int n, count = 0, i = 0, j = 0, k = 0;

  (void)! scanf("%d", &n);

    // we check for a, a - 1 and a - 2 for efficiency
    // so we start at a = 3 and go up to n + 2
  for (int a = 3; a <= n + 2; ++a) {
    k = j;
    j = i;
    i = isSemiprime(a);

    if (i && j && k) 
      ++count;
  } 

  printf("%d\n", count);
  return 0;
}

