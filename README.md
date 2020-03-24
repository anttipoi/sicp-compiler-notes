# Trials on SICP -> WASM compilation

## Demonstration: how does SICP register machine code translate to WASM

Translating LISP code for factorial 

    (define (factorial n)
        (define (iter product counter)
            (if (> counter n) 
                product
                (iter (* counter product)
                      (+ counter 1))))
        (iter 1 1))

by hand _à la SICP_ produces the following register machine code:

    factorial
      (assign product 1)
      (assign counter 1)
    iter
      (test (op >) (reg counter) (reg n))
      (branch (label fact-done))
      (assign product (op *) (reg product) (reg counter))
      (assign counter (op +) (reg counter) (const 1)) 
      (goto (label iter))
    fact-done

Note that the compiler provided in the book of course produces much more complicated code. 
Translating this register code to WAT by hand can give you a feel on how this intermediate
format maps to WASM, however.

## Running the demo

Run 

    make
    python -m SimpleHTTPServer

and visit http://localhost:8000/playground.html for some factorial fun.

## Notes

* main is special glue code that knows about the register conventions chosen: _n_ is the input register
and _product_ gives the output at the end
* SICP register code lines map quite nicely to WASM constructs
* WASM does not have nice switch case structure so I chose to split code sequences between labels 
to separate functions. These functions are named after the labels.
* stack is eventually overrun here. It should be trivial to convert to tail-recursive
`return_call` instrcutions.