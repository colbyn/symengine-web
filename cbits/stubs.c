#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

void* __cxa_begin_catch(void* exceptionObject) {abort();}
void __cxa_rethrow() {abort();}
void __cxa_end_catch() {abort();}
void* __cxa_allocate_exception(size_t thrown_size) {abort();}
void __cxa_free_exception(void * thrown_exception) {abort();}
void __cxa_throw(void* thrown_exception, void* tinfo, void (*dest)(void*)) {abort();}

#ifdef __cplusplus
}
#endif