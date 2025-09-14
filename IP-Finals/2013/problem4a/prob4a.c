/* file: prob4a.c
   author: David De Potter
   description: IP Final 2013, problem 4a, 
   Iterative algorithms, special number
*/

#include <stdio.h>
#include <stdlib.h>

void getDigitFreq(int n, int freq[]) {
  // sets freq[i] to the frequency of digit i in n
  while (n > 0) {
    freq[n % 10]++;
    n /= 10;
  }
}

int main(int argc, char *argv[]) {
  for (int n = 1; ; ++n) {
    int i, factor, freq[10] = {0};
    getDigitFreq(n, freq); 
    for (factor = 2; factor <= 6; ++factor){
      int freq2[10] = {0};
      getDigitFreq(n * factor, freq2);
      for (i = 0; i < 10; ++i)
        if (freq[i] != freq2[i]) break;
      if (i < 10) break;
    }
    if (factor > 6) {
      printf("%d\n", n);
      return 0;
    }
  }
}