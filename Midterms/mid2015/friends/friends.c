/* file: friends.c 
* author: David De Potter
* description: problem 5, your friend is my friend, mid2015
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int m, n, singletons=0, connectors= 0, p1, p2;
  int* freq;
  scanf("%d %d", &n, &m);

  /* creates an array in which each cell represents the frequency
   * of a person in the list of pairs (there are m given pairs) */
  freq = calloc(n, sizeof(int));
    //default frequency is set to 0
  for (int i=0; i < m; ++i) {
    scanf("%d %d", &p1, &p2);
    freq[p1] += 1;
    freq[p2] += 1;
  }

  /* goes through the list keeping track of singletons (freq = 0)
   * and connectors (freq = 2) */
  for (int i=0; i<n; ++i) {
    if (freq[i] == 0) singletons++;
    if (freq[i] == 2) connectors++;
  }

  free(freq);
  printf("%d\n", singletons + m/connectors);
  return 0;
}
