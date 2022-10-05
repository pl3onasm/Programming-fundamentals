/* file: prob3.c
   author: David De Potter
   description: IP Final 2016, problem 3, 
   k-even subsequence
*/

#include <stdio.h>
#include <stdlib.h>

void naive_kEvenCheck (int *a, int n, int k){
  //naive way to test if the subsequent sums of k elements
  //are even, since you are recomputing the sums over and
  //over again, which becomes a big problem for larger k
  for (int i = 0; i < n-k; i++) {
    int sum = 0;
    for (int j = i; j < i+k; j++)
      sum += a[j];
    if (sum % 2) {
      printf("NO\n");
      return;
    }
  }
  printf("YES\n");
}

void kEvenCheck (int *a, int n, int k){
  //more efficient way to test if the subsequent sums of k
  //elements are even, by using the fact the next sum to check
  //is the previous sum minus the first element and plus the
  //next element; this way you don't have to recompute the sum 
  //of all the elements in between over and over again
  int sum = 0;
  for (int i = 0; i < k; i++) sum += a[i];
  for (int i = 0; i < n-k+1; i++) {
    if (sum % 2) {
      printf("NO\n"); 
      return;
    }
    sum += a[i+k] - a[i];
  }
  printf("YES\n");
}


int main(int argc, char *argv[]) {
  int n, k; 
  scanf("%d %d\n", &n, &k);
  int *a = malloc(n * sizeof(int));
  for (int i = 0; i < n; i++) {
    scanf("%d ", a + i);
  }
  kEvenCheck(a, n, k);
  return 0;
}