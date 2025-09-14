/* 
  file: prob4.c
  author: David De Potter
  description: 3-3rd resit exam 2024, problem 4,
    minimal palindromic insertions
  note: this is a variation on problem 5 from 2021:
    https://github.com/pl3onasm/Imperative-programming/
    blob/main/IP-Finals/2021/problem5/prob5-2.c
*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>

int getMinInserts (char *s, int start, int end) {
  // base cases
  if (start == end) 
    return 0;
  if (start > end) 
    return INT_MAX;
  if (start == end - 1)
    return s[start] == s[end] ? 0 : 1;

  // recursive cases
  if (s[start] == s[end])  // no insertion needed 
    return getMinInserts(s, start + 1, end - 1); 

  // skip start, insert at end
  int x = getMinInserts(s, start + 1, end);   
  // skip end, insert at start
  int y = getMinInserts(s, start, end - 1);   
  
  return 1 + (x < y ? x : y);
}

int main(){
  char word[32];
  (void)! scanf("%s", word);
  
  printf("%d\n", getMinInserts(word, 0, strlen(word) - 1));
  return 0; 
}