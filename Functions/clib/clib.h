/* file: clib.h
   author: David De Potter
   description: header file for the clib library
   NOTES:
   - I mostly use ints just to be in line with the course material. 
   - I have not wrapped any macros in do { ... } while(0) loops, 
     because I don't see the need for it.
   - Always use a unique name for the array or matrix when using 
     the create and read macros, as the macro creates a variable 
     with that name. No need to declare the variable before using
     the macro.
*/

#ifndef CLIB_H_INCLUDED    
#define CLIB_H_INCLUDED

#include <stdio.h>    // for printf, scanf
#include <stdlib.h>   // for malloc, calloc, realloc, free
#include <math.h>     // for sqrt
#include <string.h>   // for strcpy, strlen, memcpy
#include <ctype.h>    // for tolower

//::::::::::::::::::::::::: MACROS :::::::::::::::::::::::::::::://

  // macros for min, max, abs, and sign
#define MAX(a, b) ((a) > (b) ? (a) : (b))

#define MIN(a, b) ((a) < (b) ? (a) : (b))

#define SIGN(a) ((a) > 0 ? 1 : ((a) < 0 ? -1 : 0))

  // macro definition for swapping two variables
#define SWAP(a, b) swap(&a, &b, sizeof(a))

  // macro for printing an array of a given type and length
  // Examples:  PRINT_ARRAY(myInts, "%d", 10);
  //            PRINT_ARRAY(myDbls, "%.2lf", 20);
#define PRINT_ARRAY(arr, format, len)\
  for (int arr##i = 0; arr##i < len; ++arr##i){\
    printf(format, arr[arr##i]);\
    printf(arr##i == len-1 ? "\n" : ", ");\
  }

  // macro for printing a matrix of a given type and dimensions
  // Examples:  PRINT_MATRIX(myInts, "%d", rows, cols);
  //            PRINT_MATRIX(myDbls, "%.2lf", rows, cols);
  //            PRINT_MATRIX(myChrs, "%c", rows, cols);
#define PRINT_MATRIX(matrix, format, rows, cols)\
  for (int matrix##i = 0; matrix##i < rows; ++matrix##i) {\
    for (int matrix##j = 0; matrix##j < cols; ++matrix##j) {\
      printf(format, matrix[matrix##i][matrix##j]);\
      printf(matrix##j == cols-1 ? "\n" : " ");\
    }\
  }

  // macro for creating an array of a given type and length
  // Examples:  CREATE_ARRAY(myInts, int, 10, 0);
  //            CREATE_ARRAY(myDbls, double, 20, DOUBLE_MIN);
  //            CREATE_ARRAY(myString, 15, '\0');
#define CREATE_ARRAY(type, arr, len, init)\
  type *arr = safeCalloc(len, sizeof(type));\
  if (init)\
    for (int arr##i = 0; arr##i < len; ++arr##i)\
      arr[arr##i] = init;

  // macro for creating a matrix of given type and dimensions
  // Examples:  CREATE_MATRIX(myInts, int, 10, 10, INT_MAX);
  //            CREATE_MATRIX(myDbls, double, 10, 15, 1);
  //            CREATE_MATRIX(myChrs, char, 15, 10, '\0');
#define CREATE_MATRIX(type, matrix, rows, cols, init) \
  type **matrix = safeCalloc(rows, sizeof(type *)); \
  for (int matrix##i = 0; matrix##i < rows; ++matrix##i) { \
    matrix[matrix##i] = safeCalloc(cols, sizeof(type)); \
    if (init) \
      for (int matrix##j = 0; matrix##j < cols; ++matrix##j) \
        matrix[matrix##i][matrix##j] = init; \
  }

  // macro for freeing the memory of a matrix 
#define FREE_MATRIX(matrix, rows) \
  for (int matrix##i = 0; matrix##i < rows; ++matrix##i) \
    free(matrix[matrix##i]); \
  free(matrix);

  // macro for reading input into an array of known length
  // Examples:  READ_ARRAY(myInts, "%d", 20);
  //            READ_ARRAY(myDbls, "%lf", 15);
  //            READ_ARRAY(myString, "%c", 10);
#define READ_ARRAY(arr, format, len) \
  for (int arr##i = 0; arr##i < len; ++arr##i) \
    (void)! scanf(format, &arr[arr##i]);

  // macro for reading input into a matrix of given dimensions
  // Examples:  READ_MATRIX(myInts, "%d", 10, 5);
  //            READ_MATRIX(myDbls, "%lf", 8, 8);
  //            READ_MATRIX(myChrs, "%c", 5, 10);
#define READ_MATRIX(matrix, format, rows, cols) \
  for (int arr##i = 0; arr##i < rows; ++arr##i) \
    for (int arr##j = 0; arr##j < cols; ++arr##j) \
      (void)! scanf(format, &matrix[arr##i][arr##j]);

  // macro for reading input from stdin as long as it lasts
  // creates a new array of the given type and format, and
  // a new variable size with the number of elements read
  // also sets the last element to '\0'
  // Examples:  READ(int, "%d", myInts, myIntsLen);
  //            READ(double, "%lf", myDbls, myDblsLen);
  //            READ(char, "%c", myChrs, myChrsLen);
#define READ(type, arr, format, size) \
  type *arr = safeCalloc(100, sizeof(type)); \
  int size = 0; type arr##var; \
  while (scanf(format, &arr##var) == 1) { \
    arr[size++] = arr##var; \
    if (size % 100 == 0) { \
      arr = safeRealloc(arr, (size + 100) * sizeof(type)); \
      memset(arr + size, 0, 100); \
    } \
  } \
  arr[size] = '\0'

  // macro for reading input from stdin until a given 
  // delimiter is encountered. The delimiter should not be
  // able to be interpreted as part of the input.
  // Returns a new array of the given type and creates a
  // new variable size with the number of elements read
  // Examples:  READ_UNTIL(double, myDbls, "%lf", '\n', myDblsLen);
  //            READ_UNTIL(int, myInts, "%d", '.', myIntsLen);
#define READ_UNTIL(type, arr, format, delim, size) \
  type *arr = safeCalloc(100, sizeof(type)); \
  int size = 0; type arr##var; \
  while (scanf(format, &arr##var) == 1) { \
    arr[size++] = arr##var; \
    if (size% 100 == 0) { \
      arr = safeRealloc(arr, (size + 100) * sizeof(type)); \
      memset(arr + size, 0, 100); \
    } \
  } \
  arr[size] = '\0';\
  (void) ! scanf("%*c ")
  
  // macro for reading a string from stdin until a given
  // delimiter is encountered, which is not part of the string
  // Returns a new array of chars and creates a new variable
  // size with the number of elements read
  // Examples:  READ_STR_UNTIL(myString, '\n', myStrLen);
  //            READ_STR_UNTIL(myString, '.', myStrLen);
#define READ_STR_UNTIL(str, delim, size) \
  char *str = safeCalloc(100, sizeof(char)); \
  int size = 0; char str##var; \
  while (scanf("%c", &str##var) == 1 && str##var != delim) { \
    str[size++] = str##var; \
    if (size % 100 == 0) { \
      str = safeRealloc(str, (size + 100) * sizeof(char)); \
      memset(str + size, 0, 100); \
    } \
  } \
  str[size] = '\0'
  

//::::::::::::::::::::::::: INTEGERS.C :::::::::::::::::::::::::://

  // returns the number of digits in the given integer
int countDigits(int a);
    
  // returns the reverse of the given integer as a new integer
  // Input of at most 9 digits long to avoid overflow
int reverseInt(int a);
    
  // returns the integer a with the leftmost digit moved
  // to the rightmost position. Input of at most 9 digits. 
int leftRotate(int a);
    
  // returns the integer a with the rightmost digit moved
  // to the leftmost position. Input of at most 9 digits.
int rightRotate(int a);
    
  // returns a string with the binary representation of a,
  // to be freed by the caller; assumes a is non-negative
char *toBinary(int a);
    
  // returns 1 if the year is a leap year, 0 otherwise
int isLeapYear(int year);
    
  // converts the integer to a string, to be freed by the caller
char *toString(int a);
    
  // returns 1 if the integer is a palindrome, 0 otherwise
int isIntPalindrome(int a);
    
//:::::::::::::::::::::::::: MATH.C :::::::::::::::::::::::::::::://

  // returns 1 if the integer is prime, 0 otherwise
  // input is assumed to be non-negative
int isPrime(int a);

  // returns 1 if the integer is a perfect square, 0 otherwise
  // input is assumed to be non-negative
int isPerfSquare(int a);
  
  // returns 1 if b evenly divides a, 0 otherwise
int isDivisor(int a, int b);
    
  // returns the greatest common divisor of the two integers
  // input is assumed to be non-negative
int GCD(int a, int b);
  
  // returns the least common multiple of the two integers
  // input is assumed to be non-negative
int LCM(int a, int b);

  // returns 1 if the integers are coprime (i.e. if they 
  // have no common divisors), 0 otherwise
  // input is assumed to be non-negative
int areCoprime(int a, int b);
  
  // returns a raised to the power of exp, 
  // using repeated squaring. May overflow for large exponents
int power(int a, int exp);
  
  // returns a raised to the power of exp, modulo mod
int modExp(int a, int exp, int mod);
    
//::::::::::::::::::::::::: MEMORY.C ::::::::::::::::::::::::::::://

  // swaps two variables of any type
void swap(void *a, void *b, int size);

  // allocates memory and checks if it succeeded
void *safeMalloc(int n);
    
  // allocates memory, initialized to 0, and checks if it succeeded
void *safeCalloc(int n, int size);
    
  // reallocates memory and checks if it succeeded
void *safeRealloc(void *ptr, int newSize);
    
//:::::::::::::::::::::::: SEARCHING.C ::::::::::::::::::::::::::://

  // linear search for the key in the array of given size;
  // returns the index of the key in the array, -1 if not found
int linSearch(int *array, int size, int key);
    
  // binary search for the key in the sorted array of given size;
  // returns the index of the key in the array, -1 if not found
int binSearch(int *sorted, int size, int key);

//::::::::::::::::::::::::: STRINGS.C :::::::::::::::::::::::::::://

  // case insensitive comparison of two strings str1 and str2
  // returns 0 if equal, -1 if str1 < str2, 1 if str1 > str2
int compareStrings(char *str1, char *str2);
    
  // returns a copy of the string;
  // to be freed by the caller
char *copyString(char *str);
  
  // reverses the string in place
void reverseString(char *str);

  // checks if a (sub)string is a palindrome between
  // pointers start and end; returns 1 if true, 0 otherwise
int isStrPalindrome(char *start, char *end);

//::::::::::::::::::::::::: SORTING.C :::::::::::::::::::::::::::://

  // returns a copy of the subarray from start to end;
  // this function is needed for mergeSort
int *copySubArray(int *array, int start, int end);
    
  // sorts an array of size integers using merge sort in O(n log n)
void mergeSort(int *array, int size);
    
  // sorts an array of size integers using bubble sort in O(n²)
void bubbleSort(int *array, int size);
    
  // sorts an array of size integers using insertion sort in O(n²)
void insertionSort(int *array, int size);
    
  // sorts an array of size integers using selection sort in O(n²)
void selectionSort(int *array, int size);
    
  // sorts an array of size integers using quick sort 
  // in expected O(n log n) time, O(n²) in the worst case
void quickSort(int *array, int size);
    
  // sorts an array of size integers using counting sort in O(n);
  // assumes the range between min and max value is not too large
void countingSort(int *array, int size);
    
#endif // CLIB_H_INCLUDED
