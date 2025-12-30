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
// Compares two segments by (start, end) in increasing order
int compareSegs(const void *pa, const void *pb) {
  Seg const *a = (Seg const *)pa;
  Seg const *b = (Seg const *)pb;

  if (a->start < b->start) return -1;
  if (a->start > b->start) return  1;

  if (a->end < b->end) return -1;
  if (a->end > b->end) return  1;

  return 0;
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
// Prints segments[0..last] (inclusive)
void printSegments (Seg *segments, size_t last) {
  for (size_t i = 0; i <= last; ++i) {
    printf("[%zu,%zu)", segments[i].start, segments[i].end);
    printf(i == last ? "\n" : ",");
  }
}

//=================================================================
// Merges overlapping or touching segments and prints the result
void mergeSegments(Seg *segments, size_t n) {
  size_t out = 0;  // index of last merged segment

  for (size_t i = 1; i < n; ++i) {

      // segments are sorted by start, 
      //so segments[i].start >= segments[out].start
    if (segments[i].start <= segments[out].end) 
        // overlap or touch: just extend the end if needed
      segments[out].end = C_MAX(segments[out].end, segments[i].end);
    else 
        // disjoint: start a new merged segment
      segments[++out] = segments[i];
  }

  printSegments(segments, out);
}

//=================================================================

int main() {
  size_t n;
  assert(scanf("%zu:", &n) == 1);

  Seg *segments = readInput(n);

    // sort the segments
  qsort(segments, n, sizeof(Seg), compareSegs);

    // merge the segments
  mergeSegments(segments, n);

  free(segments);

  return 0;
}