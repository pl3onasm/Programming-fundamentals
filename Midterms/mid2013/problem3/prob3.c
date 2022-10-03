/* file: prob3.c
* author: David De Potter
* description: problem 3, amicable pairs, mid2013
*/

#include <stdio.h>
#include <stdlib.h>

int sumDivisors (int n) {
  //returns the sum of n's proper divisors
  int sum = 1;
  for (int d = 2; d * d <= n; ++d) {
    if (n % d == 0) {
      if (d * d != n) sum += d + n / d;
      else sum += d; //count square root only once
    }
  }
  return sum;
}

int main(int argc, char *argv[]) {
  int n, m, *numbers, *sums;

  scanf("%d", &n);
  numbers = calloc(n, sizeof(int));
  sums = calloc(n, sizeof(int));

  /* reads all n numbers and puts them in an array.
  * Another array stores the sum of the current number's
  * proper divisors, so they have corresponding indexes. */
  for (int i = 0; i < n; ++i) {
    scanf("%d", &m);
    numbers[i] += m;
    sums[i] += sumDivisors(m);
  }

  /* As we go through the numbers, we check if the current
   * number is equal to one of the other input numbers' sum of
   * divisors (excluding the first number). If so, then
   * we check whether that number is equal to the sum of the
   * first number's divisors. If so, we print them as a pair */
  for (int i = 0; i < n; ++i) {
    for (int j = i+1; j < n; ++j) {
      if (numbers[i] == sums[j] && numbers[j] == sums[i])
        printf ("%d %d\n", numbers[i], numbers[j]);
    }
  }

  free(numbers);
  free(sums);
  return 0;
}
