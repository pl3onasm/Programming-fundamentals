#ifndef CLIB_MEMORY_H_INCLUDED
#define CLIB_MEMORY_H_INCLUDED

#include <stddef.h> 

void  c_swap(void *a, void *b, size_t nbytes);

void *c_safeMalloc(size_t nbytes);
void *c_safeCalloc(size_t count, size_t size);
void *c_safeRealloc(void *ptr, size_t nbytes);

#endif 
