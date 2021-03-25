#include <stdio.h>
#include <iostream>
// #include <symengine/cwrapper.h>
#include <symengine/expression.h>
#include <symengine/matrix.h>
#include <symengine/add.h>
#include <symengine/functions.h>
#include <symengine/complex_double.h>
#include <symengine/pow.h>
#include <symengine/symengine_exception.h>
#include <symengine/visitor.h>
#include <symengine/solve.h>
using namespace std;

// __cxa_rethrow
// __cxa_end_catch
// __cxa_allocate_exception
// __cxa_free_exception
// __cxa_throw

// void* __cxa_begin_catch(void* exceptionObject) {abort();}
// void __cxa_rethrow() {abort();}
// void __cxa_end_catch() {abort();}
// void* __cxa_allocate_exception(size_t thrown_size) {abort();}
// void __cxa_free_exception(void * thrown_exception) {abort();}
// void __cxa_throw(void* thrown_exception, void* tinfo, void (*dest)(void*)) {abort();}

int main() {
    using SymEngine::Expression;
    using SymEngine::symbol;
    using SymEngine::eq;
    using SymEngine::integer;
    using SymEngine::real_double;
    using SymEngine::complex_double;
    using SymEngine::sin;
    using SymEngine::cos;
    using SymEngine::pi;
    using SymEngine::print_stack_on_segfault;
    using SymEngine::RCP;
    using SymEngine::rational;
    using SymEngine::DenseMatrix;
    using SymEngine::Basic;
    using SymEngine::Complex;
    using SymEngine::Symbol;
    using SymEngine::is_a;
    using SymEngine::set_basic;
    using SymEngine::Add;
    using SymEngine::minus_one;
    using SymEngine::CSRMatrix;
    using SymEngine::add;
    using SymEngine::sub;
    using SymEngine::eye;
    using SymEngine::diag;
    using SymEngine::vec_basic;
    using SymEngine::function_symbol;
    using SymEngine::permutelist;
    using SymEngine::SymEngineException;
    using SymEngine::eigen_values;
    using SymEngine::finiteset;
    using SymEngine::one;
    using SymEngine::mul;
    using SymEngine::down_cast;
    using SymEngine::RealDouble;
    using SymEngine::conjugate;

    Expression e0("x + 1");

    vec_basic elems{
        integer(1), integer(0),
        integer(-1), integer(-2)
    };
    DenseMatrix A = DenseMatrix(2, 2, elems);

    std::cout << "value:\n" << A << std::endl;
    printf("HELLO WORLD\n");
    return 0;
}