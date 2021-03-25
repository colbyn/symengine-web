#ifndef SYMENGINE_EXCEPTION_H
#define SYMENGINE_EXCEPTION_H

#ifdef __cplusplus

#define try          if(true)
#define catch(...)   if(false)

extern "C" {
#endif

typedef enum {
    SYMENGINE_NO_EXCEPTION = 0,
    SYMENGINE_RUNTIME_ERROR = 1,
    SYMENGINE_DIV_BY_ZERO = 2,
    SYMENGINE_NOT_IMPLEMENTED = 3,
    SYMENGINE_DOMAIN_ERROR = 4,
    SYMENGINE_PARSE_ERROR = 5,
} symengine_exceptions_t;

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus

#define throw

#include <stdlib.h>
#define SymEngineException(msg) abort()
#define DivisionByZeroError(msg) abort()
#define NotImplementedError(msg) abort()
#define DomainError(msg) abort()
#define ParseError(msg) abort()

namespace SymEngine {
    class SymEngineException {};
}

#endif // __cplusplus
#endif // SYMENGINE_EXCEPTION_H
