/* file: prob3.c
   author: David De Potter
   description: problem 3, amicable pairs, mid2013
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory for an array of n elements of size k each,
// and checks for allocation errors
void *safeCalloc (size_t n, size_t k) {
  void *p = calloc(n, k);
  if (p == NULL) {
    fprintf(stderr, "Error: calloc(%zu, %zu) failed. "
                    "Out of memory?\n", n, k);
    exit(EXIT_FAILURE);
  }
  return p;
}

//=================================================================
// Returns the sum of n's proper divisors
int sumDivisors (int n) {
  if (n <= 1) return 0;

  int sum = 1;
  for (int d = 2; d * d <= n; ++d) {
    if (n % d == 0) {
      if (d * d != n) sum += d + n / d;
      else sum += d;        // count square root only once
    }
  }
  return sum;
}

//=================================================================

int main() {
  int n, m, *numbers, *sums;

  assert(scanf("%d", &n) == 1);
  numbers = safeCalloc(n, sizeof(int));
  sums    = safeCalloc(n, sizeof(int));

  /* reads all n numbers and puts them in an array.
   * Another array stores the sum of the current number's
   * proper divisors, so they have corresponding indexes. 
   */
  for (int i = 0; i < n; ++i) {
    assert(scanf("%d", &m) == 1);
    numbers[i] = m;
    sums[i] = sumDivisors(m);
  }

  /* As we go through the numbers, we check if the current
   * number is equal to one of the other input numbers' sum of
   * divisors. If so, then we check whether that number is equal
   * to the sum of the first number's divisors. If so, we print
   * them as a pair 
   */
  for (int i = 0; i < n; ++i) {
    for (int j = i + 1; j < n; ++j) {
      if (numbers[i] != numbers[j] &&
          numbers[i] == sums[j] && numbers[j] == sums[i])
        printf("%d %d\n", numbers[i], numbers[j]);
    }
  }

  free(numbers);
  free(sums);
  return 0;
}
