#ifndef CLIB_SORTING_H_INCLUDED
#define CLIB_SORTING_H_INCLUDED

#include <stddef.h> /* size_t */

void  c_mergeSort(int *arr,     size_t len);
void  c_bubbleSort(int *arr,    size_t len);
void  c_insertionSort(int *arr, size_t len);
void  c_selectionSort(int *arr, size_t len);
void  c_quickSort(int *arr,     size_t len);
void  c_countingSort(int *arr,  size_t len);

#endif