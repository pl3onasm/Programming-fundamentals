/* file: prob5-1.c
   author: David De Potter
   description: PF 1/3rd resit 2026, problem 5, 
                Longest circular common segment
   approach: brute force, trying every pair of starting positions 
             and keeping track of the longest match
   time complexity: this version is in O(n*m*min(n,m))
*/

#include <stdio.h>
#include <assert.h>

//===================================================================
// Reads an int array from standard input
void readArray(int *arr, int size) {
  int count;
  for (int i = 0; i < size; ++i) {
    count = scanf("%d", &arr[i]);
    assert(count == 1);
  }
}

//===================================================================

int main() {
  int n, m, a[500], b[500];
  int count = scanf("%d %d", &n, &m);
  assert(count == 2);

  readArray(a, n);
  readArray(b, m);

  int limit = n < m ? n : m;
  int best = 0, start = 0;

    // try every pair of starting positions
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < m; ++j) {
      int length = 0;

        // compare consecutive elements, wrapping around as needed
      while (length < limit &&
             a[(i + length) % n] == b[(j + length) % m]) {
        ++length;
      }

        // ignoring ties keeps the smallest start in the first array
      if (length > best) {
        best = length;
        start = i;
      }
    }
  }

  printf("[");
  for (int k = 0; k < best; ++k)
    printf("%s%d", k == 0 ? "" : ",", a[(start + k) % n]);
  printf("]\n");

  return 0;
}