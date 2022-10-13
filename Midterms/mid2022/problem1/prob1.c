/* file: prob1.c
   author: David De Potter
   description: IP mid2022, problem 1, time difference
*/

#include <stdio.h>
#include <stdlib.h>

int abs(x) {
  return x < 0 ? -x : x;
} 

void readTime(int time[3]){
  for (int i = 0; i < 3; i++){
    time[i] = (getchar() - '0') * 10 + (getchar() - '0');
    getchar(); // skip ':' or ' '
  }
}

int main(int argc, char *argv[]) {
  int time1[3], time2[3]; 
  readTime(time1);
  readTime(time2);
  int diff = (time2[0] - time1[0]) * 3600 + 
    (time2[1] - time1[1]) * 60 + (time2[2] - time1[2]);
  printf("%02d:%02d:%02d\n", abs(diff/3600), abs((diff%3600)/60), abs(diff%60));
  return 0;
}