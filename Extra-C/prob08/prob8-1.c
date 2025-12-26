/* 
  file: prob8-1.c
  author: David De Potter
  description: extra, problem 8, segments
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define MAX(a,b) ((a)>(b)?(a):(b))
#define MIN(a,b) ((a)<(b)?(a):(b))

//=================================================================
// Segment structure
typedef struct {
  size_t start, end;
} Seg;

//=================================================================
// Allocates memory and checks if allocation was successful
void *safeMalloc (size_t n) {
  void *p = malloc(n);
  if (p == NULL) {
    printf("Error: malloc(%zu) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return p;
}

//=================================================================
// Reads the input segments and returns them as an array
Seg* readInput (size_t len) {
  Seg *segments = safeMalloc(len * sizeof(Seg));
  
  for (size_t i = 0; i < len; ++i)
    assert(scanf("[%zu,%zu),", &segments[i].start, 
                               &segments[i].end) == 2);
  
  return segments;
}

//=================================================================
// Copies a part of a given segment array from the left index to 
// the right one
Seg *copySubArray(size_t left, size_t right, Seg *arr) {
  Seg *copy = safeMalloc((right - left)*sizeof(Seg));

  for (size_t i = left; i < right; i++)
    copy[i - left] = arr[i];
  
  return copy;
}

//=================================================================
// Mergesorts the given array of segments by their start field 
// in increasing order
void mergeSort(size_t length, Seg *arr) {
  size_t l = 0, r = 0, idx = 0, mid = length/2;

  if (length <= 1) return;

  Seg *left = copySubArray(0, mid, arr);
  Seg *right = copySubArray(mid, length, arr);

  mergeSort(mid, left);
  mergeSort(length - mid, right);
  
  while (l < mid && r < length - mid) {
    if (left[l].start < right[r].start)
      arr[idx++] = left[l++];
    else
      arr[idx++] = right[r++];
  }

  while (l < mid) 
    arr[idx++] = left[l++];
  
  while (r < length - mid) 
    arr[idx++] = right[r++];

  free(left);
  free(right);
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
      segments[curr].start = MIN (a.start, b.start);
      segments[curr].end = MAX (a.end, b.end);
    } else segments[++curr] = b;
  }
  printSegments (segments, curr);
}

//=================================================================

int main() {
  size_t n;
  assert(scanf("%zu:", &n) == 1);

  Seg *segments = readInput (n);

  mergeSort (n, segments);

  mergeSegments(segments, n);

  free(segments);

  return 0;
}