(module top (lib "eopl.ss" "eopl")
  
  ;; top level module.  Loads all required pieces.
  ;; Run the test suite with (run-all).

  (require "drscheme-init.scm")
  (require "data-structures.scm")  ; for expval constructors
  (require "lang.scm")             ; for scan&parse
  (require "interp.scm")           ; for value-of-program
  (require "tests.scm")            ; for test-list
  
  ;; since this is the top-level module, we don't really need to
  ;; provide anything, but we do so just in case.  

  (provide run)

  ;;;;;;;;;;;;;;;; interface to test harness ;;;;;;;;;;;;;;;;
  
  ;; run : String -> ExpVal
  ;; Page: 71
  (define (run string)
      (value-of-program (scan&parse string)))

;  (define f "let f = proc (x ) -(-(x, -15), 6) in (f 47)")
;  (define l "letrec mul(x, y) =
;                    if zero? (y) then 0 else -((mul x -(y, 1)), -(0, x))
;                    in (mul 5 25)" )

)

