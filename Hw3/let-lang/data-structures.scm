(module data-structures (lib "eopl.ss" "eopl")

  ;; data structures for let-lang.

  (provide (all-defined-out))               ; too many things to list

;;;;;;;;;;;;;;;; expressed values ;;;;;;;;;;;;;;;;

;;; an expressed value is either a number, a boolean or a procval.

  (define-datatype expval expval?
    [num-val
      (value number?)]
    [bool-val
      (boolean boolean?)])

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
	(bool-val (bool) bool)
	(else (expval-extractor-error 'bool v))))

  (define (expval-extractor-error variant value)
      (eopl:error 'expval-extractors "Looking for a ~s, found ~s"
	variant value))


;; 
  

;;;;;;;;;;;;;;;; environment structures ;;;;;;;;;;;;;;;;

;; example of a data type built without define-datatype

  (define (empty-env-record)
      '())

  (define (extended-env-record sym val old-env)
      (cons (list sym val) old-env))
  
  (define empty-env-record? null?)
  
  (define (environment? x)
      (or (empty-env-record? x)
          (and (pair? x)
               (symbol? (caar x))
               (expval? (cadar x))
               (environment? (cdr x)))))

  (define (extended-env-record->sym r)
      (caar r))

  (define (extended-env-record->val r)
      (cadar r))

  (define (extended-env-record->old-env r)
      (cdr r))

)
