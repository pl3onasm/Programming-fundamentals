/* file: prob1.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 1, Epoch
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int n;
                  // Epoch starts on a Thursday
  char *days[] = {"Thursday", "Friday", "Saturday", "Sunday",
                  "Monday", "Tuesday", "Wednesday"};
  
  (void)! scanf ("%d", &n);
  
  printf("%s\n", days[n / 86400 % 7]);

  return 0;
}