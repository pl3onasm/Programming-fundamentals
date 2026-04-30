/* file: prob1.c
   author: David De Potter
   description: PF 1/3rd term 2025, problem 1, BMI
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//===================================================================
// evaluates the BMI category and prints it
void evaluateBMI (double bmi) {
  if (bmi < 18.5) {
    printf("UNDERWEIGHT\n");
  } else if (bmi < 25) {
    printf("HEALTHY\n");
  } else if (bmi < 30) {
    printf("OVERWEIGHT\n");
  } else {
    printf("OBESE\n");
  }
}

//===================================================================

int main() {
  int w = 0; 
  double h = 0;
  assert(scanf("%d %lf", &w, &h) == 2);

  h /= 100;           // convert cm to m
  assert(h > 0);      // avoid division by zero
  double bmi = w / (h * h);

  evaluateBMI(bmi);

  return 0;
}