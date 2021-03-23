#include <stdio.h>
#include <emscripten/emscripten.h>
#include <symengine/cwrapper.h>

// EMSCRIPTEN_KEEPALIVE int runme() {
//     printf("Hello World.....\n");
//     return 0;
// }

EMSCRIPTEN_KEEPALIVE int main(int argc, char *argv[]) {
    basic_struct *y = basic_new_heap();
    symbol_set(y, "x");
    basic_free_heap(y);
    printf("DONE\n");
    return 0;
}
