/* file: armstrong.c
* author: David De Potter
* description: IP mid2019, problem 4, Armstrong numbers
*/

#include <stdio.h>
#include <stdlib.h>

int power(int num, int exp) {
  /* returns number^exponent */
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
  /* returns length of integer n */
  int count=0;
  while (n != 0) {
    count++;
    n /= 10;
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
  scanf("%d", &n);
  for (x = 1; ;++x) {
    if (isArmstrongNumber(x)) index++;
    if (index == n) break;
  }
  printf("%d\n", x);
  return 0;
}
