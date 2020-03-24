(module 
    (memory $mem 1)

    ;; registers as globals
    (global $n (mut i32) (i32.const 0))
    (global $counter (mut i32) (i32.const 0))
    (global $product (mut i32) (i32.const 0))

    (func $factorial
        ;; (assign product 1)
        (global.set $product (i32.const 1))
        ;; (assign counter 1)
        (global.set $counter (i32.const 1))
        (call $iter))
    
    (func $iter
        ;; (test (op >) (reg counter) (reg n))
        (i32.gt_u 
                (global.get $counter)
                (global.get $n))
        ;; (branch (label fact-done))
        (if 
            (then
                (call $fact_done))
            (else
                ;; (assign product (op *) (reg product) (reg counter))
                (global.set $product 
                    (i32.mul
                        (global.get $product)
                        (global.get $counter)))
                ;; (assign counter (op +) (reg counter) (const 1))
                (global.set $counter
                    (i32.add
                        (global.get $counter)
                        (i32.const 1)))
                ;; (goto (label iter))
                (call $iter))))

    (func $fact_done
        (return))

    (func $main (param $arg-n i32) (result i32)
        (global.set $n (local.get $arg-n))
        (call $factorial)
        (global.get $product))

    (export "main" (func $main)))