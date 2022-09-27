/* file: prob3.c
   author: David De Potter
   description: IP Final 2020, problem 3, number permutations
*/

#include <stdio.h>
#include <stdlib.h>

void readDigits(int digits[]){
  char d; 
  while ((d = getchar()) >= '0' && d <= '9')
    digits[d - '0']++;
}

int checkDigitFrequencies(int m[], int n[]){
  for (int i = 0; i < 10; i++){
    if (m[i] != n[i]) return 0;
  }
  return 1;
}

int main(int argc, char **argv){
  int m[10] = {0}, n[10] = {0};
  readDigits(n);
  readDigits(m); 
  if (checkDigitFrequencies(n, m)) printf("YES\n");
  else printf("NO\n");
  return 0; 
}