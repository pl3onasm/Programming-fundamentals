/* file: spiral.c
* author: David De Potter
* description: mid2015, problem 5, 
* your friend is my friend
*/

#include <stdio.h>
#include <stdlib.h>

int hasOnlyUnseen(int row, int seen[30], int friends[30][30], int n){
  //checks if person (row) has only new (unseen) friends thus far
  for(int i = 0; i < n; i++)
    if(friends[row][i] && seen[i])
      return 0;
  return 1;
}

int main(int argc, char *argv[]) {
  int friends[30][30]={0}; // 30 is the maximum number of persons
  int n, m, groups=0, seen[30]={0};
  scanf("%d %d", &n, &m);
  for (int i = 0; i<m; ++i){
    int a, b; 
    scanf("%d %d", &a, &b);
    friends[a][b]=1;
    friends[b][a]=1;
  }
  for (int i = 0; i<n; ++i){
    seen[i]=1;
    if (hasOnlyUnseen(i, seen, friends, n)) groups++;
    for (int j = i; j<n; ++j)
      if (friends[i][j]) seen[j]=1; 
  }
  printf("%d\n", groups);
  return 0; 
}