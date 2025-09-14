/* file: prob4.c
   author: David De Potter
   description: IP Final 2017 Resit, problem 4,
	 repeated permutations
*/

#include <stdio.h>
#include <stdlib.h>

int GCD(int a, int b) {
  if (b == 0) return a;
  return GCD(b, a%b);
}

int LCM(int a, int b) {
  return a/GCD(a, b)*b;
}

int main(int argc, char *argv[]) {
  int n, op[100], cycles[100], count[100] = {0};
  (void)! scanf("%d", &n);
  for (int i = 0; i < n; i++) {
    (void)! scanf("%d", op + i);
    cycles[i] = op[i];
  }
  for (int i = 0; i < n; i++) {
    if (cycles[i] < 0) continue;
    int j = i;
    while (cycles[j] > 0) {
      int k = cycles[j];
      cycles[j] = -1;
      j = k;
      count[i]++;
    }
  }
  int lcm = count[0];
  for (int i = 1; i < n; i++) {
    if (count[i] == 0) continue;
    lcm = LCM(lcm, count[i]);
  }
  printf("%d\n", lcm);
  return 0;
}