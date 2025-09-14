/* file: prob3.c
   author: David De Potter
   description: IP Final 2017, problem 3, Missing number
   You could opt for a solution using a sort and then a 
   linear search, but then you're in O(n log n) time at best.
   We can do better by just computing the sum over the array
   and then subtracting this from the sum of first n natural
   numbers, given by n*(n+1)/2. The result is the missing number. 
   This way we're in linear time.
*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int nums[35001], n, arraySum=0;
  (void)! scanf("%d", &n);
  for (int i = 0; i < n; ++i) 
    (void)! scanf("%d", &nums[i]);
  for (int i = 0; i < n; ++i) 
    arraySum += nums[i];
  int total = n*(n+1) / 2;  // sum of first n natural numbers
  printf("%d\n", total - arraySum);
  return 0;
}