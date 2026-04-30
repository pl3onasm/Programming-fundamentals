#ifndef CLIB_SEARCHING_H_INCLUDED
#define CLIB_SEARCHING_H_INCLUDED

#include <stddef.h> /* size_t */

int c_linSearch(int const *arr,    size_t len, int key);
int c_binSearch(int const *sorted, size_t len, int key);

#endif 
