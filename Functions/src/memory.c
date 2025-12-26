#include "../include/clib/clib.h"
#include <string.h> 

//=================================================================
static inline void _die_oom(const char *what) {
  fprintf(stderr, "clib: allocation failed in %s" 
                  "(out of memory?)\n", what);  
  exit(EXIT_FAILURE);
}

//=================================================================
void c_swap(void *a, void *b, size_t nbytes) {
  if (a == b || nbytes == 0)    
    return;  
  unsigned char *buf = c_safeMalloc(nbytes);  
  memcpy(buf, a, nbytes);  
  memcpy(a, b, nbytes);  
  memcpy(b, buf, nbytes); 
  free(buf);
}

//=================================================================
void *c_safeMalloc(size_t nbytes) {
  void *p = malloc(nbytes);  
  if (!p && nbytes != 0)    
  _die_oom("malloc");  
  return p;
}

//=================================================================
void *c_safeCalloc(size_t count, size_t size) {
  void *p = calloc(count, size);  
  if (!p && count != 0 && size != 0)    
  _die_oom("calloc");  
  return p;
}

//=================================================================
void *c_safeRealloc(void *ptr, size_t nbytes) {
  void *p = realloc(ptr, nbytes);  
  if (!p && nbytes != 0)    
  _die_oom("realloc");  
  return p;
}