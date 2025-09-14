/* file: prob5-2.c
   author: David De Potter
   description: extra, problem 5, next smaller number
   version: 5.2, using the clib library
*/

#include "../../Functions/clib/clib.h"

int main() {
  char arr[20];
  (void)! scanf("%s", arr);
  
  int len = strlen(arr);
  int i = len - 2;

  // find 1st digit from the right that breaks the 
  // descending order from right to left
  while (i >= 0 && arr[i] <= arr[i + 1]) i--;

  if (i < 0) {  // number is the smallest possible
    printf("-1\n");
    return 0;
  }

  // find the next smaller digit from the right
  int j = len - 1;
  while (arr[j] >= arr[i]) j--;

  SWAP(arr[i], arr[j]);

  // sort the rest of the string in descending order
  j = len - 1;
  i++;
  while (i < j) 
    SWAP(arr[i++], arr[j--]);

  // print if there are no leading zeros
  printf(arr[0] == '0' ? "-1\n" : "%s\n", arr);

  return 0;
}
