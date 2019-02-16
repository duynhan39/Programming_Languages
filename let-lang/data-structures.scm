(module data-structures (lib "eopl.ss" "eopl")
  (require "lang.scm")

  ;; data structures for let-lang.

  (provide (all-defined-out))               ; too many things to list

;;;;;;;;;;;;;;;; expressed values ;;;;;;;;;;;;;;;;

;;; an expressed value is either a number, a boolean or a procval.

  (define-datatype expval expval?
    [num-val
     (value number?)]
    [bool-val
     (boolean boolean?)]
    [proc-val
     (proc proc?)])

  (define-datatype proc proc?
    [procedure (args (list-of symbol?))
               (body expression?)
               (savedEnv environment?)])

;;; extractors:

  ;; expval->num : ExpVal -> Int
  ;; Page: 70
  (define (expval->num v)
      (cases expval v
	[num-val (num) num]
	[else (expval-extractor-error 'num v)]))

  ;; expval->bool : ExpVal -> Bool
  ;; Page: 70
  (define (expval->bool v)
      (cases expval v
	[bool-val (bool) bool]
	[else (expval-extractor-error 'bool v)]))

  (define (expval->proc v)
    (cases expval v
      [proc-val (proc) proc]
      [else (expval-extractor-error 'proc v)]))
  

  (define (expval-extractor-error variant value)
      (eopl:error 'expval-extractors "Looking for a ~s, found ~s"
	variant value))

;;;;;;;;;;;;;;;; environment structures ;;;;;;;;;;;;;;;;

  (define-datatype environment environment?
    [empty-env-record]
    [extended-env-record (sym symbol?)
                         (val expval?)
                         (old-env environment?)]
    [extended-rec-env    (procname symbol?)
                         (args (list-of symbol?))
                         (procbody expression?)
                         (old-env environment?)])

)
