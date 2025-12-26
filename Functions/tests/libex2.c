/*
  file: libex2.c  
  author: David De Potter  
  description: example program for using the clib library  
    Compile by running the makefile in the parent directory
    Then feed it the input file:  
      ../build/bin/libex2 <input.txt  
*/
#include <stdio.h>
#include <stdlib.h>

#include "clib/clib.h"

//=================================================================
int main(void) {
  size_t rows, cols, size;  
    // read the dimensions of the matrix  
  (void)!scanf("%zu %zu", &rows, &cols);  

    // allocate memory for the 2D array  
  int **matrix;  
  C_NEW_MATRIX(int, matrix, rows, cols);  
    // read input from stdin into the matrix  
  C_READ_MATRIX(matrix, "%d", rows, cols);  
    // print the matrix  
  printf("\nThe integer matrix is:\n");  
  C_PRINT_MATRIX(matrix, "%02d", rows, cols);  
  C_FREE_MATRIX(matrix, rows);  

    // read an array of integers 
    // Input ends with a -1 sentinel value
  int *ints;  
  C_READ_UNTIL_SENTINEL(int, ints, size, "%d ", -1);  
    // print the integer array  
  printf("\nThe integer input has %zu elements:\n", size);  
  C_PRINT_ARRAY(ints, "%d", size);  
    // sort the integer array  
  c_mergeSort(ints, size);  
  printf("\nThe sorted integer array is:\n");  
  C_PRINT_ARRAY(ints, "%d", size);  
  free(ints);  

    // read the array of doubles (size is not given)  
    // Input ends with a '-' delimiter 
  double *dbls;  
  size_t dblLen;  
  C_READ_UNTIL_DELIM(double, dbls, dblLen, "%lf ", '-');  
     
    // print the array  
  printf("\nThe double input has %zu elements:\n", dblLen);  
  C_PRINT_ARRAY(dbls, "%.2lf", dblLen);  
  free(dbls);  

    // read one line of input  
  char *str;  
  size_t strLen;  
  C_READ_LINE(str, strLen);  
  printf("\nThe input string has %zu characters.\n", strLen);
  printf("\nThe input string is:\n%s\n", str);  
  free(str);  

    // read all input until the end of the file  
  size_t textLen;  
  char *text;
  C_READ_STR_UNTIL(text, textLen, EOF); 
  printf("\nThe piece of text has %zu characters:\n", textLen);  
  printf("%s\n\n", text);  
  free(text);  
  
  return 0;
}