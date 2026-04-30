/* file: prob1.c
   author: David De Potter
   description: PF 1/3rd resit 2023, problem 1, Epoch
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//=================================================================

int main() {
  int n;
    // Epoch is a Thursday, so index 0 corresponds to Thursday
  char const * days[] = {"Thursday", "Friday", "Saturday", 
                         "Sunday","Monday", "Tuesday", 
                         "Wednesday"};
  
  assert(scanf ("%d", &n) == 1);
    
    // 86400 seconds in a day = 24 * 60 * 60
  printf("%s\n", days[(n / 86400) % 7]);

  return 0;
}