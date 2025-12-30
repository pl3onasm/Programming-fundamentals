/* file: prob5-2.c
   author: David De Potter
   description: extra, problem 5, next smaller number
   version: 5.2, using the clib library
*/

#include "../../Functions/include/clib/clib.h"
#include <string.h>

//=================================================================

int main() {
  char arr[20];
  assert(scanf("%19s", arr) == 1);

  int len = (int)strlen(arr);
  int i = len - 2;

    // find 1st digit from the right that breaks the 
    // nondecreasing order (so arr[i] > arr[i+1])
  while (i >= 0 && arr[i] <= arr[i + 1]) 
    --i;

  if (i < 0) {  
    // number is the smallest possible permutation
    printf("-1\n");
    return 0;
  }

    // find the largest digit in the suffix that is still < arr[i]
  int j = len - 1;
  while (arr[j] >= arr[i]) 
    --j;

    // if there are duplicates of arr[j], use the leftmost one
    // (this gives the largest possible result after reversing)
  while (j > i + 1 && arr[j] == arr[j - 1])
    --j;

  C_SWAP(arr[i], arr[j]);

    // reverse the suffix to make it as large as possible 
  int left = i + 1;
  int right = len - 1;
  while (left < right)
    C_SWAP(arr[left++], arr[right--]);

    // reject leading zero
  if (arr[0] == '0')
    printf("-1\n");
  else
    printf("%s\n", arr);

  return 0;
}
