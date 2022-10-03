/* file: prob1.c
* author: David De Potter
* description: problem 1, 9's complement
* subtraction, resit mid2016
*/

#include <stdio.h>
#include <stdlib.h>

int power(int num, int exp) {
  int m=1;
  while (exp!=0) {
    if (exp%2 == 0) {
      num *= num; exp /= 2;
    } else {
      m *= num; exp--;
    }
  }
  return m;
}

int countDigits (int n) {
  int count = 0;
  while (n != 0) {
    count++; n /= 10;
  }
  return count;
}

int complement (int x) {
  return (power(10, countDigits(x)) -1 - x);
}

int main (int argc, char *argv[]) {
  int p, c, a, b;
  scanf ("%d %d", &a, &b);
  p = power(10, countDigits(a)) - 1;
  c = complement(a);
  printf("%d-%d=", a, b);
  printf("%d-((%d-%d)+%d=", p, p, a, b);
  printf("%d-(%d+%d)=", p, c, b);
  printf("%d-%d=", p, b+c);
  printf("%d\n", complement(b+c));
  return 0;
}
