/* file: prob4.c
   author: David De Potter
   version: 1.0, assuming that execution times do not exceed 100 hours
   description: IP Final 2015, problem 4, job scheduling
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n, jobIndex[100]={0}, timeFreqs[100]={0}, time;
  scanf("%d", &n);
  for (int i = 0; i < n; ++i) {
    scanf("%d\n", &time);
    if (!jobIndex[time]) jobIndex[time] = i+1;
    ++timeFreqs[time];
  }
  int i = 0, jobNum=0; 
  while (1){
    if (jobIndex[i]) {
      for (int j = 0; j < timeFreqs[i]; ++j) {
        printf("%d", jobIndex[i]+j);
        if (++jobNum < n) printf(","); 
      }
    }
    if (jobNum == n) break;
    ++i; 
  }
  printf("\n");
  return 0;
}