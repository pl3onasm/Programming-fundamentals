#include <math.h>

//=================================================================
int c_isPrime(int n) {
  if (n == 2) return 1;
  if (n % 2 == 0 || n < 2) return 0;
  for (int i = 3; i <= n / i; i += 2) 
    if (n % i == 0) return 0;
  return 1;
}

//=================================================================
int c_isPerfSquare(int n) {
  if (n < 0) 
    return 0;
  int root = sqrt((double)n);  
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