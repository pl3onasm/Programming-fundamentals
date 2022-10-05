/* file: prob5-2.c
  author: David De Potter
  description: IP mid2021, problem 5, matching pairs, alternative version
*/

#include <stdio.h>
#include <stdlib.h>

int readArray(int a[]) {
  int n;
  scanf("%d:", &n);
  for (int i=0; i < n; i++) {
    scanf("%d", &a[i]);
  }
return n;
}

int main(int argc, char *argv[]) {
  int a[1000000], b[1000000]; 
  int lenA = readArray(a);
  int lenB = readArray(b);
  int cnt = 0;
  for (int i=0; i < lenA; i++) {
    int idx = a[i];
    cnt += ((idx < lenB) && (b[idx] == i));
  }
  printf("%d\n", cnt);
  return 0;
}
