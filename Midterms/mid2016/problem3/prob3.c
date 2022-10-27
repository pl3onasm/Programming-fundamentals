/* file: prob3.c
* author: David De Potter
* description: problem 3, Hamming numbers, mid2016
*/

#include <stdio.h>
#include <stdlib.h>

int isDivisor (int x, int y) {
  //checks whether y is a divisor of x
  return x % y == 0;
}

int isGoodHamming (int x, int n) {
  /* checks if given number x is a Hamming number
   * with a sum of exponents that equals to n */
  int sum=0, arr[3]={5, 3, 2};
  for (int i=0; i<3; ++i) 
    while (isDivisor(x, arr[i])) {
      x /= arr[i];
      sum += 1;
    }
  return x == 1 && sum == n;
    /* true if x can be written as a product which only
     * includes the factors 2,3,5, and the exponent sum = n */
}

int main(int argc, char *argv[]) {
  int n, a, b, count=0;

  scanf("%d %d %d", &a, &b, &n);
  for(int x=a; x<=b; x++)
    if (isGoodHamming (x, n))
      count++;

  printf("%d\n", count);
  return 0;
}
