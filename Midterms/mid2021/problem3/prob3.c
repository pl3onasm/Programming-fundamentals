/* file: prob3.c
  author: David De Potter
  description: IP mid2021, problem 3, good primes
*/

#include <stdio.h>
#include <stdlib.h>

int isPrime (int x) {
  //checks whether a given number is prime
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2)
    if (x % i == 0) return 0;
  return 1;
}

int getPrecedingPrime (int p) {
  //gets the prime neighbour < p
  if (p == 2) return p;
  if (p%2 == 0) --p;
  while (!isPrime(p)) p-=2; 
  return p;
}

int getNextPrime (int p) {
  //gets the next prime neighbour 
  if (p%2 == 0) ++p;
  while (!isPrime(p)) p+=2; 
  return p;
}

int main(int argc, char *argv[]) {
  int a, b, count=0;
  
  scanf("%d %d", &a, &b);
  int smallest = getPrecedingPrime(a-1);
  int middle = getNextPrime(a);
  while (1) {
    int largest = getNextPrime(middle+1);
    if (middle*middle > smallest*largest) count++;
    smallest = middle;
    middle = largest;
    if (middle > b) break; 
  }

  printf("%d\n", count);
  return 0;
}