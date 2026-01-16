/* 
  file: prob18.c
  author: David De Potter
  description: extra, problem 18, summing with step k
  
  Approach:
  The input numbers and the sum can become very large, so we use
  a 64-bit integer type (unsigned long long int) to store them.
  Since the time limit is 1 second, looping is not an option.

  The numbers we must add form an arithmetic sequence:
    n, n+k, n+2k, ..., last
  where 'last' is the largest term that does not exceed m.

  Each term can be written as n plus some number of steps of 
  size k:
    term = n + i*k,  for i = 0, 1, 2, ...

  The last included term is the largest one that is still <= m,
  so we choose the biggest i such that:
    n + i*k <= m

  This i equals (m-n)/k (integer division), and the number of
  terms, denoted by t, is then:
    t = i + 1

  We then use the arithmetic series formula:
    S = t/2 * (first + last)

  with:
    first = n
    last  = n + i*k

  This computes the answer in constant time.
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef unsigned long long int llu;

//=================================================================

int main(void)
{
  llu n, m, k, sum;
  assert(scanf("%llu %llu %llu", &n, &m, &k) == 3);

  assert(m >= n);

  llu nSteps = (m - n) / k;
  llu nTerms = nSteps + 1;
  llu last   = n + nSteps * k;

    // Compute the sum using the arithmetic series formula 
  sum = nTerms * (n + last) / 2;

  printf("%llu\n", sum);
  return 0;
}
