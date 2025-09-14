/* file: prob1.c
  author: David De Potter
  description: IP mid2020, problem 1, palindromic numbers
*/

#include <stdio.h>
#include <stdlib.h>

int countDigits(int n) {
  int count = 0;
  while (n > 0) {
    n /= 10; 
    count++;
  }
  return count;
}

int main(int argc, char *argv[]) {
  int n, length;
  (void)! scanf("%d", &n);
  length = countDigits(n);
  printf("%d", n);
  
  for (int i=0; i < length; ++i) {
    printf("%d", n % 10);
    n /= 10; 
  }
  printf("\n");

  return 0;
}