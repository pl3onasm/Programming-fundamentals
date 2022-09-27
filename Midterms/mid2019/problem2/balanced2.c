#include <stdio.h>

int main(int argc, char *argv[]) {
  int n, balance=0;
  scanf ("%d", &n);
  while (n) {
    int digit = n%10;
    balance += digit*((digit%2 == 0) - (digit%2));
    n /= 10;
  }
  printf("%s\n", (balance ? "NO": "YES"));
  return 0;
}
