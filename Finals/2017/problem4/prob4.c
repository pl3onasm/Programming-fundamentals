/* file: prob4.c
   author: David De Potter
   description: IP Final 2017, problem 4, Transposition cipher
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void printCypher(char cypher[][20], int m, int n){
  // prints columnwise 
  for (int j=0; j<n; j++) 
    for (int i=0; i<m; i++) 
      printf("%c", cypher[i][j]);
  printf("\n");
}

int main(int argc, char *argv[]) {
  int m=0, n=1, c=0, k=0; char sent[400], ch;
  char cypher[20][20]; // sentence length <= 400 chars
  while (scanf("%c", &ch) && ch != '.') sent[k++] = ch; 
  while (m*m <= k) ++m; --m; // m = floor(sqrt(k))
  while (m*n < k) ++n; 
  for (int i=0; i<m; i++) {
    for (int j=0; j<n; j++) {
      if (c < k) {
        cypher[i][j] = sent[c] == ' ' ? '#': sent[c]; 
        c++;
      } else cypher[i][j] = '#';
    }
  }
  printCypher(cypher, m, n);
  return 0;
}