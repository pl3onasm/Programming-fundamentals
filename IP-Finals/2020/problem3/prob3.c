/* file: prob3.c
   author: David De Potter
   description: IP Final 2020, problem 3, number permutations
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================
// Reads the digits of a number from standard input
void readDigits(int digits[]){
  int d; 
  while ((d = getchar()) >= '0' && d <= '9')
    ++digits[d - '0'];
}

//=================================================================
// Checks whether the digit frequencies in m and n are the same
int sameDigitFrequencies(int m[], int n[]){
  for (int i = 0; i < 10; i++)
    if (m[i] != n[i]) return 0;
  return 1;
}

//=================================================================

int main(){
  int m[10] = {0}, n[10] = {0};

  readDigits(m);
  readDigits(n); 

  printf("%s\n", sameDigitFrequencies(m, n) ? "YES" : "NO");
  
  return 0; 
}