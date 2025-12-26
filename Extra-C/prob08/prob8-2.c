/* 
  file: prob8-2.c
  author: David De Potter
  description: extra, problem 8, segments
  version: 8.2, using the clib library and qsort
*/

#include "../../Functions/include/clib/clib.h"

//=================================================================
// Segment structure
typedef struct {
  size_t start, end;
} Seg;

//=================================================================
// Compares two segments by their start field
int compareSegs (const void *a, const void *b) {
  return ((Seg *)a)->start - ((Seg *)b)->start;
}

//=================================================================
// Reads the input segments and returns them as an array
Seg* readInput (size_t len) {
  Seg *segments = c_safeMalloc(len * sizeof(Seg));
  
  for (size_t i = 0; i < len; ++i)
    assert(scanf("[%zu,%zu),", &segments[i].start, 
                               &segments[i].end) == 2);
  return segments;
}

//=================================================================
// Prints the segments in the array
void printSegments (Seg *segments, size_t n) {
  for (size_t i = 0; i <= n; ++i) {
    printf("[%zu,%zu)", segments[i].start, segments[i].end);
    printf(i == n ? "\n" : ",");
  }
}

//=================================================================
// Keeps merging overlapping segments in the array until no more 
// merges are possible
void mergeSegments(Seg *segments, size_t n) {
  size_t curr = 0;  // index of current segment

  for (size_t i = 1; i < n; ++i) {
    Seg a = segments[curr], b = segments[i];
    if (a.end >= b.start) {   
        // overlapping segments, merge them
      segments[curr].start = C_MIN (a.start, b.start);
      segments[curr].end = C_MAX (a.end, b.end);
    } else segments[++curr] = b;
  }
  printSegments (segments, curr);
}

//=================================================================

int main() {
  size_t n;
  assert(scanf("%zu:", &n) == 1);

  Seg *segments = readInput (n);

    // sort the segments
  qsort(segments, n, sizeof(Seg), compareSegs);

    // merge the segments
  mergeSegments(segments, n);

  free(segments);

  return 0;
}