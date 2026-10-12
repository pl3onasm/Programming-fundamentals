/* file: prob5-2.c
   author: David De Potter
   description: PF 1/3rd resit 2026, problem 5, 
                Longest circular common segment
   approach: we virtually double both arrays and use dynamic
   programming to find matching segments. A match at (i,j)
   extends the match at (i+1,j+1). Segment lengths are capped
   at the shorter input array's length. Among equally long 
   segments, we choose the smallest start in the first array.
   time complexity: this version is in O(n*m) and is faster than 
   the brute force approach as we got rid of the inner while loop 
   used in prob5-1.c
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

int main(void) {
  int n, m, a[500], b[500];
  int count = scanf("%d %d", &n, &m);
  assert(count == 2);

  readArray(a, n);
  readArray(b, m);

  int limit = n < m ? n : m;
  int best = 0, start = 0;
  int matchLengths[1001] = {0};

    // process the virtual doubled arrays from the last row upwards
  for (int i = 2 * n - 1; i >= 0; --i) {
      // process j from left to right so matchLengths[j+1] still 
      // holds the match length for starting positions i+1 and j+1
    for (int j = 0; j < 2 * m; ++j) {
      if (a[i % n] == b[j % m]) {
        matchLengths[j] = matchLengths[j + 1] + 1;
        if (matchLengths[j] > limit)
          matchLengths[j] = limit;
      }
      else matchLengths[j] = 0;
        // at this point, matchLengths[j] holds the length of the 
        // match starting at (i,j)

        // consider only starting positions in the original arrays
      if (i < n && j < m && (matchLengths[j] > best || 
         (matchLengths[j] == best && i < start))) {
        best = matchLengths[j];
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
