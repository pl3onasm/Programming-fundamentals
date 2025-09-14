/* 
  file: libex2.c
  author: David De Potter
  description: example program for using the clib library
  Compile with the test script and feed it the input file:
    ../ctest.sh libex2.c 
  Usage: ./a.out <input.txt
*/

#include "clib/clib.h"

int main() {
  int rows, cols, size;

  // read the dimensions of the matrix
  (void)! scanf("%d %d", &rows, &cols);

  // allocate memory for the 2D array
  CREATE_MATRIX(int, matrix, rows, cols, 0);

  // read input from stdin into the matrix
  READ_MATRIX(matrix, "%d", rows, cols);

  // print the matrix
  printf("\nThe integer matrix is:\n");
  PRINT_MATRIX(matrix, "%02d", rows, cols);
  FREE_MATRIX(matrix, rows);

  // read an array of integers (size is given)
  (void)! scanf("%d", &size);
  CREATE_ARRAY(int, ints, size, 0);
  READ_ARRAY(ints, "%d", size);

  // print the integer array
  printf("\nThe integer input has %d elements:\n", size);
  PRINT_ARRAY(ints, "%d", size);
  
  // sort the integer array
  mergeSort(ints, size);
  printf("\nThe sorted integer array is:\n");
  PRINT_ARRAY(ints, "%d", size);
  free(ints);
  
  // read the array of doubles (size is not given)
  READ_UNTIL(double, dbls, "%lf", '-', dblLen);

  // print the array
  printf("\nThe double input has %d elements:\n", dblLen);
  PRINT_ARRAY(dbls, "%.2lf", dblLen);
  free(dbls);

  // read one line of input 
  READ_STR_UNTIL(str, '\n', strLen);
  printf("\nThe input string is:\n%s\n", str);
  free(str);

  // read all input until the end of the file 
  READ(char, text, "%c", textLen);

  printf("\nThe piece of text has %d characters:\n", textLen);
  printf("%s\n\n", text);
  free(text); 

  return 0;
}