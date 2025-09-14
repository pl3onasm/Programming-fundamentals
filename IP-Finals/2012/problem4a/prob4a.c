/* file: prob4a.c
   author: David De Potter
   description: IP Final 2012, problem 4a, 
   Iterative algorithms, permutations
*/

#include <stdio.h>
#include <stdlib.h>

int isPermutation(int length, int a[], int b []) {
   // checks if a and b are permutations of each other
   int digits1[10] = {0}, digits2[10] = {0};
   for (int i = 0; i < length; i++) {
      digits1[a[i]]++;
      digits2[b[i]]++;
   }
   for (int i = 0; i < 10; i++) 
      if (digits1[i] != digits2[i])
         return 0;
   return 1;
}

int main(int argc, char *argv[]) {
   int a[1000], b[1000], n;
   (void)! scanf("%d", &n);
   for (int i = 0; i < n; ++i) (void)! scanf("%d", &a[i]);
   for (int i = 0; i < n; ++i) (void)! scanf("%d", &b[i]);
   printf(isPermutation(n, a, b) ? "YES\n": "NO\n");
   return 0;
}