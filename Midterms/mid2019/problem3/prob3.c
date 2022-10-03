/* file: prob3.c
* author: David De Potter
* description: IP mid2019, problem 3, Martingale Red
*/

#include <stdio.h>
#include <stdlib.h>


int isRed (int n) {
  // returns 1 if n is a red number
  return (n == 1 || n == 3 || n == 5 || n == 7 || n == 9 ||
    n == 12 || n == 14 || n == 16 || n == 18 || n == 19 ||
    n == 21 || n == 23 || n == 25 || n == 27 || n == 30 ||
    n == 32 || n == 34 || n == 36);
}

int main(int argc, char *argv[]) {
  int money = 0, bet = 1, spin, valid = 1;

  scanf("%d", &money);

  while (scanf("%d", &spin) && spin != -1) {
    if (isRed(spin)) {
      money += bet;
      bet = 1;
    } else {
      money -= bet;
      bet = 2*bet;
    }
    if (money < bet) {
      valid = 0;
      printf("BUST\n");
      break;
    }
  }

  if (valid) printf("%d\n", money);

  return 0;
}
