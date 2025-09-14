/* file: prob4.c
   author: David De Potter
   description: PF 1/3term 2023, problem 4, DNA matching
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void findSubseqs(char dna[], int nA, int nC, int nT, int nG, int subLen){
  /* finds the subsequences of length subLen in dna that have 
     nA A's, nC C's, nT T's and nG G's and prints the starting index of 
     each subsequence; if no such subsequence is found, prints "NO MATCH" */
  int len = strlen(dna);
  int found = 0;
  int a = 0, c = 0, t = 0, g = 0;   // counters for A, C, T and G in subsequence
  // loop over all chars in dna
  for (int i = 0; i < len; i++){
    if (dna[i] == 'A') a++;
    else if (dna[i] == 'C') c++;
    else if (dna[i] == 'T') t++;
    else g++;
    if (i >= subLen-1){       
      // check if the last subLen chars have the correct number of A, C, T and G 
      int subStart = i - subLen + 1;
      if (a == nA && c == nC && t == nT && g == nG){
        printf(found ? ",%d" : "%d", subStart);
        found = 1;
      }
      // remove the first char of the subsequence to check the next subsequence
      // effectively applying a sliding window technique of size subLen
      if (dna[subStart] == 'A') a--;
      else if (dna[subStart] == 'C') c--;
      else if (dna[subStart] == 'T') t--;
      else g--;
    }
  }
  printf(found ? "\n" : "NO MATCH\n");
}

int main(int argc, char *argv[]) {
  char dna[100000];
  int nA, nC, nT, nG;
  
  (void)! scanf("%d %d %d %d", &nA, &nC, &nT, &nG);   
  int subLen = nA + nC + nT + nG;   // subsequence length
  
  (void)! scanf("%s", dna);
  findSubseqs(dna, nA, nC, nT, nG, subLen);

  return 0;
}