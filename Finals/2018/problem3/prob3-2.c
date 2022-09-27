/* file: prob3.c
   author: David De Potter
   description: IP Final 2018, problem 3, sum of pairs
   this version works with a histogram
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv){
  int target, hist[1001] = {0}, n, flag = 1;
  scanf("%d\n", &target);
  while (scanf("%d", &n) && n != 0) hist[n] = 1;
  for (int i=1; i<=target/2; ++i){
    int j = target - i;
    if (j<1000 && hist[i] && hist[j]){
      flag = 0; 
      printf("%d + %d\n", i, j); 
    }
  }
  if (flag) printf("NONE\n");
  return 0; 
}