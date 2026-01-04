/* file: prob4.c
   author: David De Potter
   description: IP Final 2019 resit, problem 4, 
   Horner representation
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Reads the coefficients of the polynomial from standard input
void readCoeffs (int coeffs[], int n, int *max) {
  int coeff, exp;
  for (int i = 0; i < n; i++) {
    assert(scanf("%d*x^%d%*1[+]", &coeff, &exp) == 2);
    coeffs[exp] += coeff;
    if (exp > *max) 
      *max = exp;
  }
}

//=================================================================
// Prints the Horner representation of the polynomial
void printHorner (int coeffs[], int max) { 
  for (int i = 0; i < max - 1; ++i) 
    printf("("); 
  printf("%d", coeffs[max]);
  
  for (int i = max - 1; i >= 0; --i){
    printf("*x");
    if (coeffs[i] >= 0) printf("+");
    printf("%d", coeffs[i]); 
    if (i > 0) printf(")");
  }
  printf("\n"); 
}

//=================================================================

int main(){
  int n, coeffs[101] = {0}, maxCoeff = 0; 

  assert(scanf("%d ", &n) == 1);

  readCoeffs(coeffs, n, &maxCoeff); 

  printHorner(coeffs, maxCoeff);
  return 0; 
}