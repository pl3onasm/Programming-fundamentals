/* file: prob4.c
* author: David De Potter
* description: IP mid2019, problem 4, Armstrong numbers
*/

#include <stdio.h>
#include <stdlib.h>

int power(int n, int exp) {
  // returns n^exp using binary exponentiation
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n; 
    exp /= 2;
  }
  return pow;
}

int countDigits (int n) {
  /* returns length of integer n */
  int count=0;
  while (n != 0) {
    count++; n /= 10;
  }
  return count;
}

int isArmstrongNumber (int n) {
  /* returns 1 if n is an Armstrong number,
   * else 0 */
  int digitSum = 0, p = n;
  int len = countDigits(n);
  for (int i = 0; i < len; ++i) {
    digitSum += power(p % 10, len);
    p /= 10;
  }
  return (n==digitSum);
}

int main(int argc, char *argv[]) {
  int n, x, index=0;
  (void)! scanf("%d", &n);
  for (x = 1; ;++x) {
    if (isArmstrongNumber(x)) index++;
    if (index == n) break;
  }
  printf("%d\n", x);
  return 0;
}
