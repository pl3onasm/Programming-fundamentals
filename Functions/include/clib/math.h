#ifndef CLIB_MATH_H_INCLUDED
#define CLIB_MATH_H_INCLUDED

int c_isPrime(int n);
int c_isPerfSquare(int n);
int c_isDivisor(int a, int b);

int c_gcd(int a, int b);
int c_lcm(int a, int b);
int c_areCoprime(int a, int b);
int c_power(int base, int exp);
int c_modexp(int base, int exp, int mod);


#endif
