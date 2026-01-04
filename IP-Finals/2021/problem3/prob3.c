/* file: prob3.c
   author: David De Potter
   description: IP Final 2021, problem 3, longest subsequence
*/

#include <stdio.h>
#include <stdlib.h>

//=================================================================
// Prints the output in the required format
void printOutput (int arr[]) {
  for (int i = 0; i < 26; ++i) 
    if (arr[i]) printf("%c:%d\n", i + 'a', arr[i]);
}

//=================================================================

int main(){
  int arr[26] = {0}, count = 1;
  int ch = getchar(), next;  

  while (ch != EOF && ch != '\n'){
    next = getchar();
    if (next == ch) ++count;
    else {
      if (count > arr[ch - 'a']) 
        arr[ch - 'a'] = count;
      count = 1;
    }
    ch = next;
  }
  
  printOutput(arr);
  
  return 0; 
}