/* file: prob5.c
   author: David De Potter
   description: mid2015, problem 5,
                your friend is my friend
   approach:
     The friendships form an undirected graph: each person is a 
     node, and each friendship pair is an edge. The rule "a friend 
     of my friend is my friend" means that everyone connected by a 
     chain of friendships belongs to the same friend group 
     (connected component).
     We count how many such groups there are by scanning all 
     people. Whenever we find a person we have not seen before, we 
     start from that person and mark all reachable people as seen, 
     using an explicit stack. Each new start corresponds to one 
     new group.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================
// Marks all people in start's friend group as seen 
void markFriends(int start, int n, int friends[][30], int seen[]) {
  int stack[30];
  int top = 0;

  seen[start]  = 1;
  stack[top++] = start;

  while (top > 0) {
    int v = stack[--top];

    for (int u = 0; u < n; ++u) {
      if (friends[v][u] && ! seen[u]) {
        seen[u] = 1;
        stack[top++] = u;
      }
    }
  }
}

//=================================================================

int main() {
  int friends[30][30] = {0};
  int seen[30] = {0};
  int n, m, groups = 0;

  assert(scanf("%d %d", &n, &m) == 2);

  for (int i = 0; i < m; ++i) {
    int a, b;
    assert(scanf("%d %d", &a, &b) == 2);
      // store friendships symmetrically
    friends[a][b] = 1;
    friends[b][a] = 1;
  }

  for (int i = 0; i < n; ++i) {
    if (! seen[i]) {
      ++groups;
      markFriends(i, n, friends, seen);
    }
  }

  printf("%d\n", groups);
  return 0;
}
