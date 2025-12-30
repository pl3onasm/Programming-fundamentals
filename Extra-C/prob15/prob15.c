/* 
  file: prob15.c
  author: David De Potter
  description: extra, problem 15, tricky squares
  
  Approach:
  - We need to count all numbers n in [a, b] that are perfect 
    squares and additionally satisfy the "tricky" digit condition.
  - Since b <= 10^10, the largest square root is 10^5. Therefore, 
    we can enumerate all candidate roots i in 
    [ceil(sqrt(a)), floor(sqrt(b))], compute i*i, and test whether 
    that square is "tricky".
  - A square is "tricky" if exactly one digit (0..9) appears more 
    than once. We check this by building a digit frequency table 
    and counting how many digits have frequency > 1.
*/

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef unsigned long long int llu;

//=================================================================
// Checks if n is a tricky square. A "tricky square" is a perfect 
// square whose decimal representation contains exactly one digit 
// that appears more than once.
int isTrickySquare(llu n) {
  size_t freq[10] = {0};

  while (n) {
      freq[n % 10]++;
      n /= 10;
  }

  size_t repeated = 0;
  for (size_t d = 0; d < 10; d++) {
      if (freq[d] > 1)  repeated++;
      if (repeated > 1) return 0;  
  }

  return repeated == 1;
}
//=================================================================

int main() {
  llu a, b;
  assert (scanf ("%llu %llu", &a, &b) == 2);

  llu start = ceil(sqrt((long double)a));
  llu end   = floor(sqrt((long double)b));

  size_t count = 0;
  for (llu i = start; i <= end; ++i) {
    llu square = i * i;
    if (isTrickySquare(square)) 
      ++count;
  }

  printf ("%zu\n", count);

  return 0;
}
