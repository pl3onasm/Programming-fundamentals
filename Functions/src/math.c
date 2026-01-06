#include <math.h>
#include <limits.h>
#include <stdlib.h>
#include "../include/clib/memory.h"

//=================================================================
// Initialize list of primes up to floor(sqrt(INT_MAX))
// using Sieve of Eratosthenes
static int initialized = 0;
static int *plist = NULL;
static int pcount = 0;

static void cleanupPrimes(void) {
  free(plist);
  plist = NULL;
  pcount = 0;
  initialized = 0;
}

static void initPrimes(void) {
  int limit = sqrt((double)INT_MAX);    

  unsigned char *mark = c_safeMalloc((limit + 1) * sizeof(char));

  for (int i = 0; i <= limit; ++i) mark[i] = 1;
  mark[0] = 0;
  mark[1] = 0;

  for (int p = 2; p * p <= limit; ++p)
    if (mark[p])
      for (int k = p * p; k <= limit; k += p)
        mark[k] = 0;

  for (int i = 2; i <= limit; ++i)
    if (mark[i]) ++pcount;

  plist = c_safeMalloc(pcount * sizeof(int));

  int idx = 0;
  for (int i = 2; i <= limit; ++i)
    if (mark[i]) plist[idx++] = i;

  free(mark);
  initialized = 1;

  atexit(cleanupPrimes);
}

//=================================================================
// Checks if n is prime using trial division by precomputed primes,
// which is efficient for 32-bit integers, especially for repeated 
// calls in the same program
int c_isPrime(int n) {
  if (!initialized) initPrimes();

  if (n < 2) return 0;
  if (n == 2) return 1;
  if ((n & 1) == 0) return 0;

  for (int i = 0; i < pcount; ++i) {
    int p = plist[i];

    if (p > n / p) break;

    if (n % p == 0)
      return (n == p);
  }

  return 1;
}

//=================================================================
int c_isPerfSquare(int n) {
  if (n < 0) 
    return 0;
  int root = sqrt((double)n) + 0.5;  
  return root * root == n;
}

//=================================================================
int c_isDivisor(int a, int b) {
  if (b == 0) 
    return 0;  
  return a % b == 0;
}

//=================================================================
int c_gcd(int a, int b) {
  if (a < 0) a = -a;  
  if (b < 0) b = -b;  
  while (b != 0) {    
    int t = a % b;    
    a = b;    
    b = t;  
  }  
  return a;
}

//=================================================================
int c_lcm(int a, int b) {
  if (a == 0 || b == 0) 
    return 0;  
  return (a / c_gcd(a, b)) * b;
}

//=================================================================
int c_areCoprime(int a, int b) {
  return c_gcd(a, b) == 1;
}

//=================================================================
int c_power(int base, int exp) {
  int pow = 1;  
  while (exp > 0) {    
    if (exp & 1) pow *= base;    
    if (exp > 1) base *= base;    
    exp >>= 1;
  }  
  return pow;
}

//=================================================================
int c_modexp(int base, int exp, int mod) {
  int pow = 1;  
  base %= mod;  
  while (exp > 0) {    
    if (exp & 1) pow = (pow * base) % mod;    
    if (exp > 1) base = (base * base) % mod;    
    exp >>= 1; 
  }  
  return pow;
}