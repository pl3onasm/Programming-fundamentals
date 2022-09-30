/* file: squaring.c
* author: David De Potter
* description: problem2, squaring digits, mid2015
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n, counter=0, sum, digit, number;

  scanf("%d", &n);  
  for (int i=1; i<=n; ++i) {
    sum = 0, number = i;
    while ((sum != 89) && (sum != 1)) {
      sum = 0;
      while (number != 0) {
        digit = number%10;
        sum += digit*digit;
        number /= 10;
      }
      if (sum == 89) counter++;
      else number = sum;
    }
  }

  printf("%d\n", counter); 
  return 0;
}
