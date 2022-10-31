/* file: vocabulary.c
   author: David De Potter
   description: this file presents a basic vocabulary of 
   functions that you should know and be able to plug into
   your program in order to quickly solve a given problem. 
*/

#include <stdio.h>
#include <stdlib.h>

int abs(x) {
  // returns the absolute value of x
  return x < 0 ? -x : x;
} 

int max(int x, int y) {
  // returns the maximum of x and y
  return x > y ? x : y;
}

int min(int x, int y) {
  // returns the minimum of x and y
  return x < y ? x : y;
}

int countDigits (int n) {
  // returns the number of digits in n
  int count = 0;
  while (n > 0) {
    n /= 10;
    count++;
  }
  return count;
}

void swap (int *arr, int i, int j ) {
  /* swaps the content of cells with indexes
     i and j in the given array */
  int h = arr[i];
  arr[i] = arr[j];
  arr[j] = h;
}

void swap2 (int *a, int *b) {
  // swaps the values of pointers a and b
  int tmp = *a;
  *a = *b;
  *b = tmp;
}

int reverse(int n) {
  // returns the reverse of a given integer n
  int rev = 0;
  while (n > 0) {
    rev = rev * 10 + n % 10;
    n /= 10;
  }
  return rev;
}

int leftRotate (int x) {
  /* returns the left rotation of a given number x,
     ignoring leading zeros, e.g. 1234 -> 2341 */
  int pow = power(10, countDigits(x)-1);
  int firstDigit = x / pow;
  int rotation = (x % pow)*10 + firstDigit;
  return rotation;
}

int rightRotate (int x) {
  /* returns the right rotation of a given number x,
     ignoring leading zeros, e.g. 1234 -> 4123 */
  int pow = power(10, countDigits(x)-1);
  int lastDigit = x % 10;
  int rotation = lastDigit * pow + x / 10;
  return rotation;
}

int isPrime (int x) {
  // returns 1 if x is prime, 0 otherwise
  if (x == 2) return 1;
  if (x % 2 == 0 || x == 1) return 0;
  for (int i = 3; i*i <= x; i += 2) 
    if (x % i == 0) return 0;
  return 1;
}

int isPerfSquare (int n) {
  // returns 1 if n is a perfect square, 0 otherwise
  int i; 
  for (i=1; i*i < n; ++i);
  return (i*i == n); 
}

int toBinary (int n, int *bin) {
  /* converts n to binary and stores the result in bin
     returns length of binary representation */
  int len = 0;
  while (n > 0) {
    bin[len++] = n % 2; 
    n >>= 1;
  }
  return len; 
}

int isLeapYear(int year) {
  // determines whether the given year is a leap year
  if (year % 400 == 0) return 1;
  if (year % 100 == 0) return 0;
  if (year % 4 == 0) return 1;
  return 0;
}

//::::::::::::::::::::::::: DIVISIBILITY :::::::::::::::::::::::://

int isDivisor (int x, int y) {
  // checks whether y is a divisor of x
  return x % y == 0;
}

int GCD (int a, int b) {
  // returns the greatest common divisor of a and b
  if (b == 0) return a;
  return GCD(b, a % b);
}

int LCM (int a, int b) {
  // returns the least common multiple of a and b
  return a / GCD(a, b) * b;
}

int haveNoCommonDivs (int a, int b) {
  /* checks if a and b have no common divisors,
     i.e. if they're coprime */
  return GCD(a, b) == 1;
}

int sumDivisors (int n) {
  // returns the sum of n's proper divisors
  int sum = 1;
  for (int d = 2; d * d <= n; ++d) {
    if (n % d == 0) {
      if (d * d != n) sum += d + n / d;
      else sum += d; //count square root only once
    }
  }
  return sum;
}

//:::::::::::::::::::::::: EXPONENTIATION ::::::::::::::::::::::://

int power(int n, int exp) {
  /* returns n^exp using exponentiation by squaring, 
     aka binary exponentiation */
  int m=1;
  while (exp != 0) {
    if (exp%2 == 0) {
      n *= n; exp /= 2;
    } else {
      m *= n; exp--;
    }
  }
  return m;
}

int modExp (int a, int b, int n) {
  /* computes a^b mod n using modular exponentiation */
  int r = 1;
  while (b > 0) {
    if (b % 2) r = (r * a) % n;
    a = (a * a) % n;
    b /= 2;
  }
  return r % n;
}

//::::::::::::::::::::: PALINDROME CHECKERS ::::::::::::::::::::://

int isIntPalindrome(int n) {
  // checks whether a given integer n is a palindrome
  int rev = 0, m = n;
  while (m > 0) {
    rev = rev * 10 + m % 10;
    m /= 10;
  }
  return rev == n;
}

int isPalindrome (int start, int end, char *s) {
  /* checks whether a given string s is a palindrome
     between the given start and end indexes */
  if (start >= end) return 1;
  if (s[start] != s[end]) return 0;
  return isPalindrome(start+1, end-1, s);
} 

//:::::::::::::::::::::: MEMORY ALLOCATION :::::::::::::::::::::://

void *safeMalloc (int n) {
  /* allocates n bytes of memory and checks whether the allocation
     was successful */
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

void *safeCalloc (int n, int size) {
  /* allocates n elements of size size, initializing them to 0, and
     checks whether the allocation was successful */
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%d, %d) failed. Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

int *createArray (int size) {
  // creates an array of size integers
  int *arr = safeMalloc(size * sizeof(int));
  return arr;
}

char *createString(int size){
  // creates a string of size characters
  char *string = safeMalloc(size * sizeof(char));
  return string;
}

int **createMatrix (int rows, int cols) {
  // creates a matrix of size rows x cols
  int **matrix = safeMalloc(rows * sizeof(int *));
  for (int i = 0; i < rows; i++)
    matrix[i] = createArray(cols);
  return matrix;
}

int **createNullMatrix(int m, int n) {
  // creates a m x n null matrix, using safeCalloc
  int **matrix = safeCalloc(m,sizeof(int*));
  for (int i=0; i<m; ++i)
    matrix[i] = safeCalloc(n,sizeof(int));
  return matrix;
}

void freeMatrix (int **matrix, int rows) {
  // frees a matrix of size rows x cols
  for (int i = 0; i < rows; i++)
    free(matrix[i]);
  free(matrix);
}

void *safeRealloc (void *ptr, int newSize) {
  // reallocates memory and checks whether the allocation was successful
  ptr = realloc(ptr, newSize);
  if (ptr == NULL) {
    printf("Error: realloc(%d) failed. Out of memory?\n", newSize);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//:::::::::::::::::::::::::: PRINTING :::::::::::::::::::::::::://

void printArray (int *arr, int n) {
  // prints an array of size n
  printf("[");
  for (int i = 0; i < n; i++) {
    printf("%d", arr[i]);
    if (i < n-1) printf(", ");
  }
  printf("]\n");
}

void printMatrix (int **matrix, int rows, int cols) {
  // prints a matrix of size rows x cols
  printf("[");
  for (int i = 0; i < rows; i++) {
    printf("[");
    for (int j = 0; j < cols; j++) {
      printf("%d", matrix[i][j]);
      if (j < cols-1) printf(", ");
    }
    printf("]");
    if (i < rows-1) printf(",\n");
  }
  printf("]\n");
}

//::::::::::::::::::::::::::: INPUT :::::::::::::::::::::::::::://

void readIntArray(int *arr, int size){
  // reads an array of size integers from stdin
  for (int i=0; i < size; i++) 
    scanf("%d", &arr[i]);
}

void readIntMatrix(int m, int n, int **arr) {
  // reads an mxn matrix from stdin
  for (int i=0; i<m; ++i) 
    for (int j=0; j<n; ++j) 
      scanf("%d", &arr[i][j]);
}

int *readIntVector(int *size) {
  /* reads int array as long as integer input lasts; 
     stores its length in size */
  int n, len=0, *vec = safeMalloc(100*sizeof(int)); 
  while (scanf("%d", &n) == 1) {
    vec[len++] = n;
    if (len % 100 == 0)
      vec = safeRealloc(vec, (len+100)*sizeof(int));
  }
  *size = len;
  return vec;
}

char *readText(int *size) {
  /* reads a string from stdin, including new line chars, 
     and returns the string and stores its length in size */
  char c; int len = 0; 
  char *str = safeMalloc(100*sizeof(char));
  while (scanf("%c", &c) == 1) {
    str[len++] = c; 
    if (len % 100 == 0) str = safeRealloc(str, (len+100) * sizeof(char));
  }
  str[len] = '\0';
  *size = len;
  return str;
}

char *readLine(int *size) {
  /* reads a line from stdin, returns the string, 
     and stores its length in size  */
  char c; int len = 0; 
  char *str = safeMalloc(100*sizeof(char));
  while (scanf("%c", &c) == 1 && c != '\n') {
    str[len++] = c; 
    if (len % 100 == 0) str = safeRealloc(str, (len+100) * sizeof(char));
  }
  str[len] = '\0';
  *size = len;
  return str;
}

//:::::::::::::::::::::::::: SORTING ::::::::::::::::::::::::::://

int *copySubArray(int left, int right, int arr[]) {
  /* copies the subarray arr[left..right] into a new array;
     this function is needed for mergeSort and is given on the exam */
  int i, *copy = safeMalloc((right - left)*sizeof(int));
  for (i=left; i < right; i++) 
    copy[i - left] = arr[i];
  return copy;
}

void mergeSort(int length, int arr[]) {
  /* sorts an array of integers using merge sort;
     this function is given on the exam */
  int l, r, mid, idx, *left, *right;
  if (length <= 1) {
    return;
  }
  mid = length/2;
  left = copySubArray(0, mid, arr);
  right = copySubArray(mid, length, arr);
  mergeSort(mid, left);
  mergeSort(length - mid, right);
  idx = 0;
  l = 0;
  r = 0;
  while ((l < mid) && (r < length - mid)) {
    if (left[l] < right[r]) {
      arr[idx] = left[l];
      l++;
    } else {
      arr[idx] = right[r];
      r++;
    }
    idx++;
  }
  while (l < mid) {
    arr[idx] = left[l];
    idx++;
    l++;
  }
  while (r < length - mid) {
    arr[idx] = right[r];
    idx++;
    r++;
  }
  free(left);
  free(right);
}

void bubbleSort(int *arr, int len) {
  /* sorts an array of integers using bubble sort */
  int i, j, change;
  for (i=0; i < len; ++i) {
    change=0;
    for (j=0; j+1 < len - i; ++j) {
      if (arr[j] > arr[j+1]) {
        swap(arr, j, j+1);
        change = 1;
      }
    }
    if (change == 0) break;
  }
}

//::::::::::::::::::::::::::: STRINGS :::::::::::::::::::::::::://

/* in case you're not allowed to use the string library and
   you need to implement your own functions */

int stringLength(char *s) {
  // returns the length of a string
  int len = 0;
  while (s[len] != '\0') len++;
  return len;
}

int stringCompare(char *s1, char *s2) {
  /* compares two strings: 
     returns 0 if they are equal, -1 if s1 < s2, 1 if s1 > s2 */
  int i = 0;
  while (s1[i] != '\0' && s2[i] != '\0') {
    if (s1[i] < s2[i]) return -1;
    if (s1[i] > s2[i]) return 1;
    i++;
  }
  if (s1[i] == '\0' && s2[i] == '\0') return 0;
  if (s1[i] == '\0') return -1;
  return 1;
}

char *stringCopy(char *s) {
  // returns a copy of string s
  int len = stringLength(s);
  char *copy = safeMalloc((len+1)*sizeof(char));
  for (int i=0; i<=len; ++i)
    copy[i] = s[i];
  return copy;
}