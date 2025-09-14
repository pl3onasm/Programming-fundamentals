/* file: prob4-1.c
* description: problem 4,
* Fibonacci’s bunnies again, mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int a,b,c,d,e,n;

  (void)! scanf("%d", &n);
  a = 1; //F₀
  b = c = d = e = 0;
  //b = F₁, c = F₂, d = F₃, e = F₄

  while (n) {
    /* keep track of bunnies over a period of 5 years
    in which they take 1 year to mature, reproduce for 4 years,
    and die after 5 years
    
    Fₙ = Fₙ₋₁ + Fₙ₋₂ + Fₙ₋₃ + Fₙ₋₄ + Fₙ₋₅
    where Fₙ₋₁ = a, Fₙ₋₂ = b, Fₙ₋₃ = c, Fₙ₋₄ = d, Fₙ₋₅ = e */
    
    int offspring = b + c + d + e;  // bunnies produced in the last year
      
    e = d;  // after 5 years, the bunnies die
    d = c;
    c = b;
    b = a;  
    a = offspring;
    n--;
  }

  printf("%d\n", a + b + c + d + e);
  return 0;
}

