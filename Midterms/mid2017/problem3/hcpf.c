/* file: hcpf.c
* author: David De Potter
* description: problem 3, highest
* common prime factor, mid2017
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int a, b, hcpf = 1; //default for hcpf is 1
  
  scanf("%d %d", &a, &b);
  for(int d = 2; (d <= a) && (d <= b); d++) {
    if ((a % d == 0) && (b % d == 0))
      //if d divides both, then let d be the current highest cpf
      hcpf = d;
    while (a % d == 0) a /= d;
     //divides until d no longer occurs in a's prime factorization
    while (b % d == 0) b /= d;
     //divides until d no longer occurs in b's prime factorization
  }
  printf("%d\n", hcpf);
  return 0;
}
