/* file: prob5.c
   author: David De Potter
   description: IP Final 2020, problem 5, choice maximization
*/

#include <stdio.h>
#include <stdlib.h>

int *readIntVector(int size) {
  int i, *vec = malloc(size*sizeof(int));
  for (i=0; i < size; i++) {
    scanf("%d", &vec[i]);
  }
  return vec;
}

void maximize(int *vec, int size, int index, int len, int sum, int *max){
  if (index >= size){
    if (sum > *max) *max = sum;
    return;
  }
  if (len < 2){   // we can still add
    maximize(vec, size, index + 1, len + 1, sum + vec[index], max);
  }
  maximize(vec, size, index + 1, 0, sum, max);  //skip
}

int main(int argc, char **argv){
  int n, max = 0; 
  scanf("%d: ", &n);
  int *vec = readIntVector(n); 
  maximize(vec, n, 0, 0, 0, &max); 
  printf("%d\n", max);
  return 0; 
}