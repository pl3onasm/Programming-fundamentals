/* file: prob5-1.c
   author: David De Potter
   description: extra, problem 5, next smaller number

   Approach:
    We must find the largest number m < n that uses exactly the 
    same digits as n. This is the "previous permutation" of the 
    digit sequence of n.

    We scan from right to left to find the first position i where 
    the digits stop being nondecreasing (i.e. arr[i] > arr[i+1]). 
    This is the pivot that we can decrease. If no such i exists, 
    then n is already the smallest permutation, so the answer is 
    -1.

    Next, in the suffix to the right of i, we swap arr[i] with 
    the largest digit that is still smaller than arr[i]. Finally, 
    we reverse the suffix to make it as large as possible 
    (descending order), which ensures the resulting number is the 
    biggest one that is still < n.

    If the resulting number starts with 0, we output -1.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

//=================================================================
// Swaps the values of two characters
void swap(char *a, char *b) {
  char tmp = *a;
  *a = *b;
  *b = tmp; 
}

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

  swap(&arr[i], &arr[j]);

    // reverse the suffix to make it as large as possible 
  int left = i + 1;
  int right = len - 1;
  while (left < right)
    swap(&arr[left++], &arr[right--]);

    // reject leading zero
  if (arr[0] == '0')
    printf("-1\n");
  else
    printf("%s\n", arr);

  return 0;
}