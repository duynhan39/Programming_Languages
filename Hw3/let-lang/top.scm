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

  ;(define condt "cond #f ==> minus(4) #t ==> *(4, 6) end")
;  (define condt2 "cond equal? (4, 5) ==> minus(4) #t ==> *(4, 6) end")
;  (define quot "/(*(4, 9), 3)")
;  (define printt "print (5)")
;  (define printt2 "print (cond equal? (4, 5) ==> minus(4) #t ==> *(4, 6) end)")
;  (define eq "equal? (4,5)")
  
)



