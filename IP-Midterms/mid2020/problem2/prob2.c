/* file: prob2.c
  author: David De Potter
  description: IP mid2020, problem 2, Disarium numbers
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

int countDigits(int n) {
  int count = 0;
  while (n) {
    n /= 10; 
    count++;
  }
  return count;
}

int main(int argc, char *argv[]) {
  int n, length, sum = 0;
  (void)! scanf("%d", &n);

  length = countDigits(n);
  int unit = power(10,length-1);
  int m = n;
  
  for (int i=1; i <= length; ++i){
    sum += power(n/unit, i);
    n %= unit;
    if (unit > 1) unit /= 10;
  }

  printf(m == sum ? "YES\n" : "NO\n");
  return 0;
}