;; Nhan Cao
(module interp (lib "eopl.ss" "eopl")
  
  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")

  (provide value-of-program value-of)

  ;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  ;; Page: 71
  (define (value-of-program pgm)
    (cases program pgm
      [a-program (exp1)
                 (value-of exp1 (init-env))]))

  ;; value-of : Exp * Env -> ExpVal
  ;; Page: 71
  (define (value-of exp env)
    (cases expression exp

      [const-exp (num) (num-val num)]

      [var-exp (var) (apply-env env var)]

      [diff-exp (exp1 exp2)
                (let* ([val1 (value-of exp1 env)]
                       [val2 (value-of exp2 env)]
                       [num1 (expval->num val1)]
                       [num2 (expval->num val2)])
                  (num-val
                   (- num1 num2)))]
        
      [zero?-exp (exp1)
                 (let* ([val1 (value-of exp1 env)]
                        [num1 (expval->num val1)])
                   (if (zero? num1)
                       (bool-val #t)
                       (bool-val #f)))]
        
      [if-exp (condition then-exp else-exp)
              (let ([cond-val (value-of condition env)])
                (if (expval->bool cond-val)
                    (value-of then-exp env)
                    (value-of else-exp env)))]
        
      [let-exp (var exp1 body)       
               (let ([val1 (value-of exp1 env)])
                 (value-of body
                           (extend-env var val1 env)))]

      [letrec-exp (func-name arg args func-body let-body)
                  (value-of let-body
                            (extend-rec-env func-name (cons arg args) func-body env))
                  ]
        
      [proc-exp (arg args body)
                (proc-val (procedure (cons arg args) body env))]
        
      [call-exp (operator operands)
                (let* ([func-val (value-of operator env)]   ;; evaluate the operator
                       [func (expval->proc func-val)]       ;; extract the proc
                       [op-val (lst->val operands env)])
                  (apply-proc func op-val))] 
                
      ))


  ;; Function to perform a procedure (function) call with the given argument
  ;; proc x exp-val -> exp-val
  (define (apply-proc func actual-args)
    (cases proc func
      [procedure (formals body env)
                 (value-of body (extend-env* formals actual-args env))]
      [else (eopl:error "Operator not a proc")]))

  (define (lst->val lst env)
    (cond [(null? lst)
           '()]
          [else
           (cons (value-of (car lst) env) (lst->val (cdr lst) env))]))

  )
