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
  
  (define conds "cond {equal? (5, 4) ==> -(5, 3) } {equal? (5, 5) ==> minus(10)} end")

  ;(define minus "minus(5)")
  (define printtest "print cond {equal? (5, 4) ==> -(5, 3) } {equal? (5, 5) ==> minus(10)} end")
  (define pttest "print 5")

  (define x 6)



  )



;(cond-exp (list (equal?-exp (const-exp 5) (const-exp 5))) (list (minus (const-exp 10))))