
#include "clib/clib.h"


int main () {

  CREATE_ARRAY(int, myInts, 10);
 
  for (int i = 0; i < 1; i++) {
    READ_ARRAY(myInts, "%d", 10);
    for (int j = 0; j < 10; j++) {
      PRINT_ARRAY(myInts, "%d", 10);
      myInts[j] = myInts[j] * 2;
    }
  }

  PRINT_ARRAY(myInts, "%d", 10);
  
  return 0;
}