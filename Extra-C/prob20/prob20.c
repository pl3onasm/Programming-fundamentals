/* 
  file: prob20.c
  author: David De Potter
  description: cycle counting

  Approach:
    The input defines a directed graph where each index i points 
    to next[i]. We need to count how many distinct cycles occur.

    For this, we give each traversal a unique cycle id and 
    maintain two auxiliary arrays:
      - seen[i]: whether index i has been processed already
      - mark[i]: the cycle id during the current traversal

    For each unseen start index, we follow pointers until we reach 
    an index that was already seen. If we end at an index marked 
    with the current cycle id, then we discovered a new cycle.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "../../Functions/include/clib/macros.h"

//=================================================================
// Counts how many distinct cycles occur in the given input array.
size_t countCycles(size_t *next, size_t len)
{
  if (len == 0)
    return 0;

  char *seen; 
  size_t *mark;

  C_NEW_ARRAY(char, seen, len);
  C_NEW_ARRAY(size_t, mark, len);

  size_t nCycles = 0;
  size_t cycleId = 1;

  for (size_t start = 0; start < len; ++start)
  {
    if (seen[start])
      continue;

    size_t cur = start;

    while (! seen[cur])
    {
      seen[cur] = 1;
      mark[cur] = cycleId;
      cur = next[cur];
    }

    if (mark[cur] == cycleId)
      ++nCycles;

    ++cycleId;
  }

  free(seen);
  free(mark);

  return nCycles;
}

//=================================================================

int main(void)
{
  size_t *next, len;

  C_READ_UNTIL_DELIM(size_t, next, len, "%zu", '\n');

  printf("%zu\n", countCycles(next, len));
  
  free(next);

  return 0;
}
