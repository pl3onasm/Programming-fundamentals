/* file: prob4.c
* description: problem 4,
* Fibonacci’s bunnies again, mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int a,b,c,d,e,n;

  scanf("%d", &n);
  a = 1; //F0
  b = c = d = e = 0;
  //b = Fn-2, c = Fn-3, d = Fn-4, e = Fn-5

  while (n>0) {
    //keep track of Fn over a period of 5 years
    int offspring = b + c + d + e;
      //Fn = Fn-2 + Fn-2 + Fn-4 + Fn-5
    e = d;
    d = c;
    c = b;
    b = a;  //offset of 2 because of the start
    a = offspring;
    n--;
  }

  printf("%d\n", a + b + c + d + e);
  return 0;
}

