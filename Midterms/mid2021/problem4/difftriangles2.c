/* file: difftriangles.c
  author: David De Potter
  description: IP mid2021, problem 4, difference triangles, alternative version
*/

#include <stdio.h>
#include <stdlib.h>

void showArray(int len, int a[]) {
  printf("%d", a[0]);
  for (int i=1; i < len; i++) {
    printf(" %d", a[i]);
  }
  printf("\n");
}

int main(int argc, char *argv[]) {
  int len, a[1000];
  scanf("%d", &len);
  for (int i=0; i < len; i++) {
    scanf("%d", &a[i]);
  }
  showArray(len, a);
  while (len > 1) {
    len--;
    for (int i=0; i < len; i++) {
      a[i] = (a[i] < a[i+1] ? a[i+1]-a[i] : a[i]-a[i+1]);
    }
    showArray(len, a);
  }
  return 0;
}
