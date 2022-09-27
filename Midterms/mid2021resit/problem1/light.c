/* file: light.c
   author: David De Potter
   description: IP mid2021 resit, problem 1, light numbers
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n, sum = 0, digit, max = 0, occurrence = 0; 
  scanf("%d", &n);
  while (n > 0) {
    digit = n % 10;
    n /= 10;
    sum += digit;
    if (digit == max) occurrence++;
    if (digit > max) {
      max = digit;
      occurrence = 1;
    }
  }
  if (sum - occurrence * max < max) printf("YES\n");
  else printf("NO\n");
  return 0;
}