#ifndef CLIB_MACROS_H_INCLUDED
#define CLIB_MACROS_H_INCLUDED

#include <stdio.h>    
#include <stddef.h>   /* size_t */
#include <stdlib.h>  
#include "memory.h"   

#define C_MAX(a, b)                                                 \
  (((a) > (b)) ? (a) : (b))

#define C_MIN(a, b)                                                 \
  (((a) < (b)) ? (a) : (b))

#define C_SIGN(a)                                                   \
  (((a) > 0) ? 1 : (((a) < 0) ? -1 : 0))

/* Byte-wise swap: arguments must be lvalues of the same size. */
#define C_SWAP(a, b)                                                \
  do {                                                              \
    c_swap(&(a), &(b), sizeof(a));                                  \
  } while (0)

/* Allocate an array: caller must declare the pointer. */
#define C_NEW_ARRAY(type, out_ptr, len)                             \
  do {                                                              \
    (out_ptr) = (type *)c_safeCalloc((len), sizeof(type));          \
  } while (0)

/* Allocate an array and initialize all elements to a value. */
#define C_NEW_ARRAY_FILL(type, out_ptr, len, value)                 \
  do {                                                              \
    C_NEW_ARRAY(type, out_ptr, len);                                \
    for (size_t _i = 0; _i < (size_t)(len); ++_i) {                 \
      (out_ptr)[_i] = (value);                                      \
    }                                                               \
  } while (0)

/* Allocates a matrix: caller must declare the pointer. */
#define C_NEW_MATRIX(type, out_mat, rows, cols)                     \
  do {                                                              \
    (out_mat) = (type **)c_safeCalloc((rows), sizeof(type *));      \
    for (size_t _i = 0; _i < (size_t)(rows); ++_i) {                \
      (out_mat)[_i] = (type *)c_safeCalloc((cols), sizeof(type));   \
    }                                                               \
  } while (0)

/* Allocates a matrix and initializes all elements to a value. */
#define C_NEW_MATRIX_FILL(type, out_mat, rows, cols, value)         \
  do {                                                              \
    C_NEW_MATRIX(type, out_mat, rows, cols);                        \
    for (size_t _i = 0; _i < (size_t)(rows); ++_i) {                \
      for (size_t _j = 0; _j < (size_t)(cols); ++_j) {              \
        (out_mat)[_i][_j] = (value);                                \
      }                                                             \
    }                                                               \
  } while (0)

/* Frees allocated memory for a matrix */
#define C_FREE_MATRIX(mat, rows)                                    \
  do {                                                              \
    for (size_t _i = 0; _i < (size_t)(rows); ++_i) {                \
      free((mat)[_i]);                                              \
    }                                                               \
    free((mat));                                                    \
  } while (0)

/* Prints an array. Elements are separated by 'sep' */
#define C_PRINT_ARRAY(arr, format, len, sep)                        \
  do {                                                              \
    for (size_t _i = 0; _i < (size_t)(len); ++_i) {                 \
      printf((format), (arr)[_i]);                                  \
      printf(_i + 1 == (size_t)(len) ? "\n" : (sep));               \
    }                                                               \
  } while (0)

/* Prints a matrix. Elements are separated by 'sep' 
   and rows by newlines */
#define C_PRINT_MATRIX(mat, format, rows, cols, sep)                \
  do {                                                              \
    for (size_t _i = 0; _i < (size_t)(rows); ++_i) {                \
      for (size_t _j = 0; _j < (size_t)(cols); ++_j) {              \
        printf((format), (mat)[_i][_j]);                            \
        printf(_j + 1 == (size_t)(cols) ? "\n" : (sep));            \
      }                                                             \
    }                                                               \
  } while (0)

/* Reads fixed-size array/matrix.
   Note: use format strings like "%d " or "%f "
   if you want whitespace skipped. */
#define C_READ_ARRAY(arr, format, len)                              \
  do {                                                              \
    for (size_t _i = 0; _i < (size_t)(len); ++_i) {                 \
      (void)!scanf((format), &(arr)[_i]);                           \
    }                                                               \
  } while (0)

#define C_READ_MATRIX(mat, format, rows, cols)                      \
  do {                                                              \
    for (size_t _i = 0; _i < (size_t)(rows); ++_i) {                \
      for (size_t _j = 0; _j < (size_t)(cols); ++_j) {              \
        (void)!scanf((format), &(mat)[_i][_j]);                     \
      }                                                             \
    }                                                               \
  } while (0)

/* Read values into a new dynamic array until a sentinel value 
   - sentinel is of the same type as the array elements
   - sentinel is NOT stored
   - stops on scanf failure / EOF
   - after each successful read, skips spaces and tabs
*/
#define C_READ_UNTIL_SENTINEL(type, out_ptr, out_len,               \
                              format, sentinel)                     \
  do {                                                              \
    size_t _cap = 100, _n = 0;                                      \
    type *_arr = (type *)c_safeCalloc(_cap, sizeof(type));          \
                                                                    \
    while (1) {                                                     \
      type _tmp;                                                    \
      int _rc = scanf((format), &_tmp);                             \
      if (_rc != 1)                                                 \
        break;                                                      \
                                                                    \
      if (_tmp == (type)(sentinel))                                 \
        break;                                                      \
                                                                    \
      if (_n == _cap) {                                             \
        _cap *= 2;                                                  \
        _arr = (type *)c_safeRealloc(_arr, _cap * sizeof(type));    \
      }                                                             \
      _arr[_n++] = _tmp;                                            \
                                                                    \
      /* skip spaces and tabs */                                    \
      int _c;                                                       \
      do {                                                          \
        _c = getchar();                                             \
        if (_c == EOF)                                              \
          break;                                                    \
      } while (_c == ' ' || _c == '\t');                            \
      if (_c != EOF)                                                \
        ungetc(_c, stdin);                                          \
    }                                                               \
                                                                    \
    (out_ptr) = _arr;                                               \
    (out_len) = _n;                                                 \
  } while (0)

/* Read values into a new dynamic array until a delimiter
   - delimiter is not of the same type as the array elements
   - delimiter is NOT stored
   - stops on scanf failure / EOF
   - after each successful read, consumes spaces/tabs/\r 
     and checks delimiter
     (so delim='\n' ends at end-of-line)
*/
#define C_READ_UNTIL_DELIM(type, out_ptr, out_len, format, delim)   \
  do {                                                              \
    size_t _cap = 100, _n = 0;                                      \
    type *_arr = (type *)c_safeCalloc(_cap, sizeof(type));          \
                                                                    \
    while (1) {                                                     \
      type _tmp;                                                    \
      int _rc = scanf((format), &_tmp);                             \
      if (_rc != 1)                                                 \
        break;                                                      \
                                                                    \
      if (_n == _cap) {                                             \
        _cap *= 2;                                                  \
        _arr = (type *)c_safeRealloc(_arr, _cap * sizeof(type));    \
      }                                                             \
      _arr[_n++] = _tmp;                                            \
                                                                    \
      int _c;                                                       \
      do {                                                          \
        _c = getchar();                                             \
        if (_c == EOF)                                              \
          break;                                                    \
      } while (_c == ' ' || _c == '\t' || _c == '\r');              \
                                                                    \
      if (_c == (int)(delim))                                       \
        break;                                                      \
                                                                    \
      if (_c != EOF)                                                \
        ungetc(_c, stdin);                                          \
    }                                                               \
                                                                    \
    (out_ptr) = _arr;                                               \
    (out_len) = _n;                                                 \
  } while (0)

/* Read a string from stdin until a delimiter
   - delimiter is NOT stored
   - stops on EOF
   - resulting string is null-terminated
   - out_ptr must be char*
*/
#define C_READ_STR_UNTIL(out_ptr, out_len, delim)                   \
  do {                                                              \
    size_t _cap = 100, _n = 0;                                      \
    char *_s = (char *)c_safeCalloc(_cap, sizeof(char));            \
                                                                    \
    while (1) {                                                     \
      int _c = getchar();                                           \
      if (_c == EOF || _c == (delim))                               \
        break;                                                      \
      if (_n + 1 == _cap) {                                         \
        _cap *= 2;                                                  \
        _s = (char *)c_safeRealloc(_s, _cap * sizeof(char));        \
      }                                                             \
      _s[_n++] = (char)_c;                                          \
    }                                                               \
    _s[_n] = '\0';                                                  \
    (out_ptr) = _s;                                                 \
    (out_len) = _n;                                                 \
  } while (0)

/* Read the next non-empty line, skipping leading 
   '\n' and '\r' characters.
*/
#define C_READ_LINE(out_ptr, out_len)                               \
  do {                                                              \
    int _c;                                                         \
    do {                                                            \
      _c = getchar();                                               \
      if (_c == EOF)                                                \
        break;                                                      \
    } while (_c == '\n' || _c == '\r');                             \
                                                                    \
    if (_c == EOF) {                                                \
      char *_s = (char *)c_safeCalloc(1, sizeof(char));             \
      _s[0] = '\0';                                                 \
      (out_ptr) = _s;                                               \
      (out_len) = 0;                                                \
    } else {                                                        \
      ungetc(_c, stdin);                                            \
      C_READ_STR_UNTIL(out_ptr, out_len, '\n');                     \
    }                                                               \
  } while (0)

#endif