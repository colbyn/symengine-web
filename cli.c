#include <string.h>
#include <math.h>
#include <stdio.h>
#include <symengine/cwrapper.h>

int main() {
    char *str = "123";
    basic_struct *p = basic_new_heap();
    CWRAPPER_OUTPUT_TYPE error = basic_parse(p, str);
    // SYMENGINE_C_ASSERT(is_a_Integer(p));
    // SYMENGINE_C_ASSERT(integer_get_si(p) == 444);
    // basic_free_heap(p);
    
    return 0;
}

