/* file: udivisors.c
  author: David De Potter
  description: IP mid2020 resit, problem 2, unitary divisors
*/

#include <stdio.h>
#include <stdlib.h>

void swap(int *a, int *b)  {
  int p = *a;
  *a = *b;
  *b = p;
}

int haveNoCommonDivs(int a, int b) {
  //checks whether a and b have no common divisors
  if (a > b) swap(&a, &b);
  for (int i=2; i <= a; ++i)
    if (a%i==0 && b%i == 0) return 0;
  if (b%a == 0) return 0;
  return 1;
}

int main(int argc, char *argv[]) {
  int n, d; 
  
  scanf("%d %d", &d, &n);
  if (n%d == 0 && haveNoCommonDivs(d, n/d)) printf("YES");
  else printf("NO\n");

  return 0;
}