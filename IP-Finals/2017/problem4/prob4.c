/* file: prob4.c
   author: David De Potter
   description: IP Final 2017, problem 4, Transposition cipher
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================
// Prints the cypher text columnwise
void printCypher(char cypher[][20], int m, int n){
  for (int j = 0; j < n; ++j) 
    for (int i = 0; i < m; ++i) 
      printf("%c", cypher[i][j]);
  printf("\n");
}

//=================================================================

int main() {
  int m = 0, c = 0, k = 0; 
  char sent[400], ch;    // sentence length <= 400 chars
  char cypher[20][20];  

  while (scanf("%c", &ch) == 1 && ch != '.') 
    sent[k++] = ch; 
    
    // m = floor(sqrt(k))
  while ((m + 1) * (m + 1) <= k) ++m;

    // n = ceil(k / m)
  int n = (k + m - 1) / m;
  
  for (int i = 0; i < m; ++i) {
    for (int j = 0; j < n; ++j) {
      if (c < k) {
        cypher[i][j] = sent[c] == ' ' ? '#': sent[c]; 
        c++;
      } else cypher[i][j] = '#';
    }
  }
  
  printCypher(cypher, m, n);
  
  return 0;
}