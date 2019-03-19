(module store (lib "eopl.ss" "eopl")
  
  (require "drscheme-init.scm")
  
  (provide initialize-store! reference? newref deref setref! the-store)

  ;;;;;;;;;;;;;;;; references and the store ;;;;;;;;;;;;;;;;

  ;; the-store: a Scheme variable containing the current state of the
  ;; store.  Initially set to a dummy variable.
  (define the-store 'uninitialized)

  (define memory-size 100)
  
  ;; empty-store : () -> Store
  ;;    first element is the index of the last reference used
  (define (empty-store)
    (make-vector memory-size 0))
  
  ;; initialize-store! : () -> Sto
  ;; usage: (initialize-store!) sets the-store to the empty-store
  ;; Page 111
  (define (initialize-store!)
    (set! the-store (empty-store)))

  ;; reference? : SchemeVal -> Bool
  ;; Page: 111
  (define (reference? v)
    (integer? v))

  ;; newref : ExpVal -> Ref
  ;; Page: 111
  (define (newref val)
    (let ([next-ref (+ 1 (vector-ref the-store 0))])   ;; first element is the index of last reference
      (if (equal? next-ref (vector-length the-store))
          (eopl:error "Out of memory!")
          (begin
            (vector-set! the-store 0 next-ref)        ;; update the next reference    the-store[0] = next-ref
            (vector-set! the-store next-ref val)      ;; the-store[next-ref] = val
            next-ref))))

  ;; deref : Ref -> ExpVal
  ;; Page 111
  (define (deref ref) 
    (vector-ref the-store ref))

  ;; setref! : Ref * ExpVal -> Unspecified
  ;; Page: 112
  (define (setref! ref val)
    (vector-set! the-store ref val))
  )