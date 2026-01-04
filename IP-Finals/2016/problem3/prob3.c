/* file: prob3.c
   author: David De Potter
   description: IP Final 2016, problem 3, 
     k-even subsequence
   complexity: the naive solution is in O(n*k), 
     the efficient solution is in O(n)
   note: you can also choose to just keep track of the parity
     of the sums instead of the sums themselves
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Allocates memory and checks for allocation errors
void *safeMalloc (size_t n) {
  void *ptr = malloc(n);
  if (ptr == NULL) {
    fprintf(stderr, "Error: malloc(%zu) failed. "
                    "Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//=================================================================
// Naive way to check if all subsequent sums of k elements are even
// In this version, we recompute the sums over and over again
// which is inefficient for larger k
void naive_kEvenCheck (int *a, int n, int k){
  for (int i = 0; i < n - k + 1; ++i) {
    int sum = 0;
    for (int j = i; j < i + k; ++j)
      sum += a[j];
    if (sum % 2) {
      printf("NO\n");
      return;
    }
  }
  printf("YES\n");
}

//=================================================================
// More efficient way to check if all subsequent sums of k elements
// are even. In this version, we use the previous sum to compute
// the next sum by subtracting the first element and adding the 
// next element. This way we avoid recomputing sums from scratch.
void kEvenCheck (int *a, int n, int k){
  int sum = 0;
  for (int i = 0; i < k; ++i) 
    sum += a[i];
  for (int i = 0; i < n - k + 1; ++i) {
    if (sum % 2) {
      printf("NO\n"); 
      return;
    }
    sum += a[i + k] - a[i];
  }
  printf("YES\n");
}

//=================================================================

int main() {
  int n, k; 
  assert(scanf("%d %d\n", &n, &k) == 2);

  int *a = safeMalloc((n + 1) * sizeof(int));

  for (int i = 0; i < n; ++i) 
    assert(scanf("%d", a + i) == 1);
  
  kEvenCheck(a, n, k);

  free(a);
  return 0;
}