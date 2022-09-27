/* file: disarium.c
  author: David De Potter
  description: IP mid2020, problem 2, Disarium numbers
*/

#include <stdio.h>
#include <stdlib.h>

int power(int number, int exponent) {
  int m=1;
  while (exponent!=0) {
    if (exponent%2 == 0) {
      number = number*number;
      exponent = exponent/2;
    } else {
      m = m*number;
      exponent--;
    }
  }
  return m;
}

int countDigits(int n) {
  int count = 0;
  while (n > 0) {
    n /= 10;
    count++;
  }
  return count;
}

int main(int argc, char *argv[]) {
  int n, length, sum = 0;
  scanf("%d", &n);
  length = countDigits(n);
  int unit = power(10,length-1);
  int m = n;
  for (int i=1; i <= length; ++i){
      sum += power(n/unit, i);
      n %= unit;
      if (unit > 1) unit /= 10;
  }
  if (m == sum) printf("YES\n");
  else printf("NO\n");

  return 0;
}