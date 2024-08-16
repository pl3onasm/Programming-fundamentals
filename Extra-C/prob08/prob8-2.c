/* 
  file: prob8-2.c
  author: David De Potter
  description: extra, problem 8, segments
  version: 8.2, using the clib library and qsort
*/

#include "../../Functions/clib/clib.h"

typedef struct {
  int start, end;
} Seg;

int compareSegs (const void *a, const void *b) {
  /* compares two segments by their start field */
  return ((Seg *)a)->start - ((Seg *)b)->start;
}

Seg* readInput (int len) {
  /* reads the input and stores it as an array of segments */
  Seg *segments = safeMalloc(len*sizeof(Seg));
  
  for (int i = 0; i < len; ++i)
    (void)! scanf("[%d,%d),", &segments[i].start, &segments[i].end);
  return segments;
}

void printSegments (Seg *segments, int n) {
  /* prints the segments in the array */
  for (int i = 0; i <= n; ++i) {
    printf("[%d,%d)", segments[i].start, segments[i].end);
    printf(i == n ? "\n" : ",");
  }
}

void mergeSegments(Seg *segments, int n) {
  /* checks each segment pair and keeps merging them as long 
   * as the value of the end field of the current segment
   * overlaps the start field's value of the next */
  
  int curr = 0; // index of current segment in the merged (sub)array

  for (int i = 1; i < n; ++i) {
    Seg a = segments[curr], b = segments[i];
    if (a.end >= b.start) {   
      // merge segments
      segments[curr].start = MIN (a.start, b.start);
      segments[curr].end = MAX (a.end, b.end);
    } else segments[++curr] = b;
  }
  printSegments (segments, curr);
}

int main() {
  int n;
  (void)! scanf("%d:", &n);

  Seg *segments = readInput (n);

  // sort the segments
  qsort(segments, n, sizeof(Seg), compareSegs);

  // merge the segments
  mergeSegments(segments, n);

  free(segments);

  return 0;
}