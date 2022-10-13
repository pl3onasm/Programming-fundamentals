/* file: prob2.c
   author: David De Potter
   description: IP mid2022, problem 2, coalitions
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int a=0, b=0, c=0; char ch; 
  while ((ch = getchar()) && ch != EOF) {
    if (ch == 'A') a++;
    if (ch == 'B') b++;
    if (ch == 'C') c++;
  }
  int half = (a + b + c) / 2, coalitions = 0;
  int combis[7] = {a, b, c, a+b, a+c, b+c, a+b+c};
  for (int i = 0; i < 7; i++)
    if (combis[i] > half) coalitions++;

  if (!a || !b || !c) coalitions -= 2;
  if (!a && !b || !a && !c || !b && !c) coalitions--;
  printf("%d\n", coalitions);
  return 0;
}