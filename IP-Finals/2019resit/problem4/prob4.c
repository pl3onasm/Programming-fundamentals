/* file: prob4.c
   author: David De Potter
   description: IP Final 2019 resit, problem 4, 
   Horner representation
*/

#include <stdio.h>
#include <stdlib.h>

void readCoeffs (int coeffs[], int n, int *max) {
  int coeff, exp;
  for (int i = 0; i < n; i++) {
    (void)! scanf("%d*x^%d+", &coeff, &exp);
    coeffs[exp] += coeff;
    if (exp > *max) *max = exp;
  }
}

void printHorner (int coeffs[], int term, int max) { 
  for (int i = 0; i < max-1; ++i) printf("("); 
  printf("%d", coeffs[max]);
  for (int i = max-1; i >= 0; --i){
    printf("*x");
    if (coeffs[i] >= 0) printf("+");
    printf("%d",coeffs[i]); 
    if (i > 0) printf(")");
  }
  printf("\n"); 
}

int main(int argc, char **argv){
  int n, coeffs[101] = {0}, maxCoeff=0; 
  (void)! scanf("%d ", &n);
  readCoeffs(coeffs, n, &maxCoeff); 
  printHorner(coeffs, 0, maxCoeff);
  return 0; 
}