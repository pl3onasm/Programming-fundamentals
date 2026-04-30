/* file: prob4.c
* description: problem 4,
* Fibonacci’s bunnies again, mid2017
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int a, b, c, d, e, n;

  assert(scanf("%d", &n) == 1);
  a = 1;               // age 0 = newborns
  b = c = d = e = 0;   // ages 1..4

  while (n) {
    /* We track rabbit pairs by age:
         a = age 0 (newborn)
         b = age 1
         c = age 2
         d = age 3
         e = age 4

       Each year, ages 1..4 produce one newborn pair each, so:
         offspring = b + c + d + e

       Then everyone grows older by 1 year, and age 4 pairs die
       after this shift.
    */

      // number of baby pairs created during this year
    int offspring = b + c + d + e;  
      
    e = d;  
    d = c;
    c = b;
    b = a;  
    a = offspring;

    --n;
  }

  printf("%d\n", a + b + c + d + e);

  return 0;
}

