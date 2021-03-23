#include <string.h>
#include <math.h>
#include <stdio.h>
#include <emscripten/emscripten.h>
#include <symengine/cwrapper.h>

EMSCRIPTEN_KEEPALIVE void run() {
    basic_struct *y = basic_new_heap();
    symbol_set(y, "x");
    SYMENGINE_C_ASSERT(is_a_Number(y) == 0);
    basic_free_heap(y);
    
    char *s = basic_str(y);
    basic_str_free(s);
    SYMENGINE_C_ASSERT(strcmp(s, "x") == 0);

    char *str = "123";
    basic_struct *p = basic_new_heap();
    CWRAPPER_OUTPUT_TYPE error = basic_parse(p, str);
    // SYMENGINE_C_ASSERT(is_a_Integer(p));
    // SYMENGINE_C_ASSERT(integer_get_si(p) == 444);
    // basic_free_heap(p);

    // basic f;
    // basic_new_stack(f);
    // CVecBasic *vec = vecbasic_new();
    // vecbasic_push_back(vec, x);
    // vecbasic_push_back(vec, y);
    // vecbasic_push_back(vec, z);
    // function_symbol_set(f, "f", vec);
    // s = basic_str(f);
    // SYMENGINE_C_ASSERT(strcmp(s, "f(x, y, z)") == 0);
    // vecbasic_free(vec);
    // basic_str_free(s);



    printf("DONE\n");
}


// STUB
EMSCRIPTEN_KEEPALIVE int main(int argc, char *argv[]) {
    int counter;
    printf("Program Name Is: %s\n",argv[0]);
    if(argc==1)
        printf("\nNo Extra Command Line Argument Passed Other Than Program Name\n");
    if(argc>=2)
    {
        printf("\nNumber Of Arguments Passed: %d",argc);
        printf("\n----Following Are The Command Line Arguments Passed----");
        for(counter=0;counter<argc;counter++) {
            printf("\nargv[%d]: %s",counter,argv[counter]);
        }
        printf("\n");
    }
    return 0;
}
