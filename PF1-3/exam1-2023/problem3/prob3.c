/* file: prob3.c
   author: your name
   description: PF 1/3term 2023, problem 3, running in circles
     The solution to this problem is to find the least common 
     multiple of all the moduli.
*/

#include <stdio.h>
#include <stdlib.h>

int readModuli(int moduli[]) {
  // reads the moduli and returns the number of moduli read
  int d = 0, count = 0; 
  for (int i = 0; i < 10; i++) {
    (void)! scanf("%d", &d);
    if (!d) break;
    moduli[count++] = d;
  }
  return count;
}

int GCD (int a, int b) {
  // returns the greatest common divisor of a and b
  if (b == 0) return a;
  return GCD(b, a % b);
}

int LCM (int a, int b) {
  // returns the least common multiple of a and b
  return a / GCD(a, b) * b;
}

int moduliLCM(int moduli[], int size) {
  // returns the LCM of all moduli
  int lcm = moduli[0];
  for (int i = 1; i < size; i++) 
    lcm = LCM(lcm, moduli[i]);
  return lcm;
}

int main(int argc, char *argv[]) {
  int moduli[10];
  int size = readModuli(moduli);
  printf("%d\n", moduliLCM(moduli, size));
  return 0;
}