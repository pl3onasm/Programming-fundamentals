/* file: reverse7.c
* author: David De Potter
* description: problem 1, reversible multiples
* of seven, mid2016
*/

#include <stdio.h>
#include <stdlib.h>

int reverse (int n) {
  //returns the reverse of a given number n
  int p = n/10, rev = n%10;
  while (p != 0) {
    rev = rev*10 + p%10;
    p /= 10;
  }
  return rev;
}

int main(int argc, char *argv[]) {
  int a, b, counter=0;
  scanf("%d %d", &a, &b);
  for (int x=a; x<=b; ++x) {
    if (((x%7) == 0) && (((reverse(x))%7) == 0))
      ++counter;
  }
  printf("%d\n", counter);
  return 0;
}
