/* file: vocabulary.c
   author: David De Potter
   description: this file presents a basic vocabulary of 
   functions that you should know and be able to plug into
   your program in order to quickly solve a given problem. 
*/

#include "vocab.h"

int abs(int x) {
  // returns the absolute value of x
  return x < 0 ? -x : x;
} 

int maximum (int x, int y) {
  // returns the maximum of x and y
  return x > y ? x : y;
}

int minimum (int x, int y) {
  // returns the minimum of x and y
  return x < y ? x : y;
}

int countDigits (int n) {
  // returns the number of digits in n
  int count = 0;
  while (n) {
    n /= 10;
    count++;
  }
  return count;
}

void swap (void *a, void *b, int size) {
  // generic swap function
  unsigned char *x = a, *y = b, tmp;
  for (int i = 0; i < size; ++i) {
    tmp = x[i];
    x[i] = y[i];
    y[i] = tmp;
  }
}

int reverseInt(int n) {
  // returns the reverse of a given integer n
  int rev = 0;
  while (n) {
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
  return (x % pow)*10 + firstDigit;
}

int rightRotate (int x) {
  /* returns the right rotation of a given number x,
     ignoring leading zeros, e.g. 1234 -> 4123 */
  int pow = power(10, countDigits(x)-1);
  int lastDigit = x % 10;
  return lastDigit * pow + x / 10;
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
  /* returns 1 if n is a perfect square, 0 otherwise;
     only use if you're not allowed to use sqrt */
  int i; 
  for (i = 1; i*i < n; ++i);
  return (i*i == n); 
}

int toBinary (int n, char *bin) {
  /* converts n to binary and stores the result in bin;
     returns the length of the binary representation */
  int len = 0;
  while (n > 0) {
    bin[len++] = n % 2 + '0';
    n >>= 1;
  }
  reverse(bin, len);
  return len; 
}

int isLeapYear(int year) {
  // determines whether the given year is a leap year
  return (year % 4 == 0 && year % 100 != 0) 
          || year % 400 == 0;
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

int areCoprime (int a, int b) {
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
  /* returns n^exp using binary exponentiation also known as
     exponentiation by squaring */
  int pow = 1;
  while (exp) {
    if (exp & 1) pow *= n; 
    if (exp > 1) n *= n;
    exp /= 2;
  }
  return pow;
}

int modExp (int n, int exp, int m) {
  /* computes n^exp mod m using modular exponentiation */
  int pow = 1; n %= m;
  while (exp) {
    if (exp & 1) pow = (pow * n) % m;
    if (exp > 1) n = (n * n) % m;
    exp /= 2;
  }
  return pow;
}

//::::::::::::::::::::: PALINDROME CHECKERS ::::::::::::::::::::://

int isIntPalindrome(int n, int base) {
  // checks whether n is a palindrome in given base
  int rev = 0, m = n;
  while (m) {
    rev = rev * base + m % base;
    m /= base;
  }
  return rev == n;
}

int isPalindrome (int start, int end, char *s) {
  /* checks whether a given string s is a palindrome
     between the given start and end indexes */
  if (start >= end) return 1;
  if (s[start] != s[end]) return 0;
  return isPalindrome(start + 1, end - 1, s);
}

//:::::::::::::::::::::: MEMORY ALLOCATION :::::::::::::::::::::://

void *safeMalloc (int n) {
  /* allocates memory and checks whether this was successful */
  void *ptr = malloc(n);
  if (ptr == NULL) {
    printf("Error: malloc(%d) failed. Out of memory?\n", n);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

void *safeCalloc (int n, int size) {
  /* allocates memory, initializing it to 0, and
     checks whether this was successful */
  void *ptr = calloc(n, size);
  if (ptr == NULL) {
    printf("Error: calloc(%d, %d) failed. Out of memory?\n", n, size);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

int *createIntArray (int size) {
  // creates an array of size integers
  return safeMalloc(size * sizeof(int));
}

char *createString(int size){
  // creates a string of size characters
  return safeMalloc(size * sizeof(char));
}

int **createIntMatrix (int rows, int cols) {
  // creates a matrix of size rows x cols
  int **matrix = safeMalloc(rows * sizeof(int *));
  for (int i = 0; i < rows; i++)
    matrix[i] = createIntArray(cols);
  return matrix;
}

int **createNullMatrix(int m, int n) {
  // creates a m x n null matrix, using safeCalloc
  int **matrix = safeCalloc(m,sizeof(int*));
  for (int i=0; i<m; ++i)
    matrix[i] = safeCalloc(n,sizeof(int));
  return matrix;
}

void freeIntMatrix (int **matrix, int rows) {
  // frees a matrix of size rows x cols
  for (int i = 0; i < rows; i++)
    free(matrix[i]);
  free(matrix);
}

void *safeRealloc (void *ptr, int newSize) {
  // reallocates memory and checks whether it was successful
  ptr = realloc(ptr, newSize);
  if (ptr == NULL) {
    printf("Error: realloc(%d) failed. Out of memory?\n", newSize);
    exit(EXIT_FAILURE);
  }
  return ptr;
}

//:::::::::::::::::::::::::: PRINTING :::::::::::::::::::::::::://

void printIntArray (int *arr, int n) {
  // prints an array of size n
  printf("[");
  for (int i = 0; i < n; i++) {
    printf("%d", arr[i]);
    if (i < n-1) printf(", ");
  }
  printf("]\n");
}

void printIntMatrix (int **matrix, int rows, int cols) {
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
    (void)! scanf("%d", &arr[i]);
}

void readIntMatrix(int **arr, int m, int n){
  // reads an mxn matrix from stdin
  for (int i=0; i<m; ++i) 
    for (int j=0; j<n; ++j) 
      (void)! scanf("%d", &arr[i][j]);
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

//:::::::::::::::::::::::::: SEARCHING ::::::::::::::::::::::::://

int linSearch (int *arr, int len, int key) {
  /* linear search: searches for key in arr and 
     returns its index if found, otherwise returns -1 */
  int i;
  for (i=0; i < len; ++i) 
    if (arr[i] == key) return i;
  return -1;
}

int binSearch (int *sorted, int len, int key) {
  /* binary search: searches for key in **sorted** array 
     and returns its index if found, otherwise returns -1 */
  int left = 0, right = len, mid;
  while (left < right) {
    mid = left + (right - left)/2;
    if (sorted[mid] == key) return mid;
    else if (sorted[mid] < key) left = mid + 1;
    else right = mid;
  }
  return -1;
}

//:::::::::::::::::::::::::: SORTING ::::::::::::::::::::::::::://

int *copySubArray(int *arr, int left, int right) {
  /* copies the subarray arr[left..right] into a new array;
     this function is needed for mergeSort and is given on the exam */
  int *copy = safeMalloc((right - left)*sizeof(int));
  for (int i = left; i < right; i++) 
    copy[i - left] = arr[i];
  return copy;
}

void mergeSort(int *arr, int length) {
  /* sorts an array of integers in O(n log n) time;
     this function is given on the exam */
  int l = 0, r = 0, idx = 0, mid = length/2;
  if (length <= 1) return;
  
  int *left = copySubArray(arr, 0, mid);
  int *right = copySubArray(arr, mid, length);

  mergeSort(left, mid);
  mergeSort(right, length - mid);
  
  while (l < mid && r < length - mid) {
    if (left[l] < right[r]) 
      arr[idx++] = left[l++];
    else 
      arr[idx++] = right[r++];
  }

  while (l < mid)
    arr[idx++] = left[l++];

  while (r < length - mid) 
    arr[idx++] = right[r++];

  free(left);
  free(right);
}

void bubbleSort(int *arr, int len) {
  /* sorts an array of integers in O(n²) */
  int i, j, change;
  for (i = 0; i < len; ++i) {
    change = 0;
    for (j = 0; j+1 < len - i; ++j) {
      if (arr[j] > arr[j+1]) {
        swap(&arr[j], &arr[j+1], sizeof(int));
        change = 1;
      }
    }
    if (! change) break;
  }
}

void insertionSort(int *arr, int len) {
  /* sorts an array of integers in O(n²) */
  int i, j, key;
  for (i = 1; i < len; ++i) {
    key = arr[i];
    j = i-1;
    while (j >= 0 && arr[j] > key) {
      arr[j+1] = arr[j];
      j--;
    }
    arr[j+1] = key;
  }
}

void selectionSort(int *arr, int len) {
  /* sorts an array of integers in O(n²) */
  int i, j, min;
  for (i = 0; i < len-1; ++i) {
    min = i;
    for (j = i+1; j < len; ++j) 
      if (arr[j] < arr[min]) min = j;
    swap(&arr[i], &arr[min], sizeof(int));
  }
}

void quickSort(int *arr, int len) {
  /* sorts an array of integers in expected ϴ(nlogn) time,
     worst-case performance, however, is in ϴ(n²) */
  int i, j, pivot;
  if (len <= 1) return;
  pivot = arr[len/2];
  for (i = 0, j = len-1; ; ++i, --j) {
    while (arr[i] < pivot) ++i;
    while (arr[j] > pivot) --j;
    if (i >= j) break;
    swap(&arr[i], &arr[j], sizeof(int));
  }
  quickSort(arr, i);
  quickSort(arr+i, len-i);
}

void countingSort(int *arr, int length) {
  /* sorts an array of integers in O(n) time */
  int min, max, range, i, j, idx = 0;
  min = max = arr[0];
  for (i = 1; i < length; i++) {
    min = minimum (arr[i], min);
    max = maximum (arr[i], max);
  }
  range = max - min + 1;
  int *count = safeCalloc(range, sizeof(int));
  for (i = 0; i < length; i++) 
    count[arr[i] - min]++;
  for (i = 0; i < range; i++) 
    for (j = 0; j < count[i]; j++)
      arr[idx++] = min + i; 
  free(count);
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

char *reverse (char *str, int len) {
  // reverses a given string
  for (int i = 0; i < len/2; ++i) 
    swap(&str[i], &str[len-i-1], sizeof(char));
  return str;
}