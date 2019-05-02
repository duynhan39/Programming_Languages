(module interp (lib "eopl.ss" "eopl")
  
  ;; interpreter for the IMPLICIT-REFS language

  (require "drscheme-init.scm")

  (require "lang.scm")
  (require "data-structures.scm")
  (require "environments.scm")
  (require "store.scm")
  
  (provide value-of-program value-of)
  ;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

  ;; value-of-program : Program -> ExpVal
  (define value-of-program 
    (lambda (pgm)
      (initialize-store!)
      (cases program pgm
        (a-stmt-program (stmt)
                        (result-of stmt (init-env)))
        ;(a-exp-program (exp)
        ;               (value-of exp (init-env)))
        )))

  ;; value-of : Exp * Env -> ExpVal
  ;; Page: 118, 119
  (define value-of
    (lambda (exp env)
      (cases expression exp

        (const-exp (num) (num-val num))

        (var-exp (var) (deref (apply-env env var)))

        (diff-exp (exp1 exp2)
                  (let ((val1 (value-of exp1 env))
                        (val2 (value-of exp2 env)))
                    (let ((num1 (expval->num val1))
                          (num2 (expval->num val2)))
                      (num-val
                       (- num1 num2)))))

        (zero?-exp (exp1)
                   (let ((val1 (value-of exp1 env)))
                     (let ((num1 (expval->num val1)))
                       (if (zero? num1)
                           (bool-val #t)
                           (bool-val #f)))))

        (not-exp (exp)
                 (let ((val1 (value-of exp env)))
                     
                   (if (expval->bool val1)
                       (bool-val #f)
                       (bool-val #t))))
              
        (if-exp (exp1 exp2 exp3)
                (let ((val1 (value-of exp1 env)))
                  (if (expval->bool val1)
                      (value-of exp2 env)
                      (value-of exp3 env))))

        (let-exp (var exp1 body)       
                 (let ((v1 (value-of exp1 env)))
                   (value-of body
                             (extend-env var (newref v1) env))))
        
        (proc-exp (var body)
                  (proc-val (procedure var body env)))

        (call-exp (rator rand)
                  (let ((proc (expval->proc (value-of rator env)))
                        (arg (value-of rand env)))
                    (apply-procedure proc arg)))

        (letrec-exp (p-names b-vars p-bodies letrec-body)
                    (value-of letrec-body
                              (extend-env-rec* p-names b-vars p-bodies env)))

        (begin-exp (exp1 exps)
                   (letrec 
                       ((value-of-begins
                         (lambda (e1 es)
                           (let ((v1 (value-of e1 env)))
                             (if (null? es)
                                 v1
                                 (value-of-begins (car es) (cdr es)))))))
                     (value-of-begins exp1 exps)))

        (assign-exp (var exp1)
                    (begin
                      (setref!
                       (apply-env env var)
                       (value-of exp1 env))
                      (num-val 27)))

        (sum-exp (exp1 exp2)
                 (let ((val1 (value-of exp1 env))
                       (val2 (value-of exp2 env)))
                   (let ((num1 (expval->num val1))
                         (num2 (expval->num val2)))
                     (num-val
                      (+ num1 num2)))))

        (mul-exp (exp1 exp2)
                 (let ((val1 (value-of exp1 env))
                       (val2 (value-of exp2 env)))
                   (let ((num1 (expval->num val1))
                         (num2 (expval->num val2)))
                     (num-val
                      (* num1 num2)))))

        )))

  (define result-of
    (lambda (stmt env)
      (cases statement stmt

        [assign-stmt (var exp1)
                     (setref!
                      (apply-env env var)
                      (value-of exp1 env))
                     (num-val 27)]

        [print-stmt (exp)
                    (display (expval->num (value-of exp env)))
                    (display "\n")
                    (num-val 1)]

        [brace-stmt (stmt stmts)
                    (for-each (lambda (s)
                                (result-of s env))
                              (cons stmt stmts))]

     
        [if-stmt (condition stmt1 stmt2)
                 (let ((cndt (value-of condition env)))
                   (if (expval->bool cndt)
                       (result-of stmt1 env)
                       (result-of stmt2 env)))]

        [while-stmt  (condition stmt)
                     (let while-loop()
                     
                       (let ((cndt (value-of condition env)))
                         (if (expval->bool cndt)
                             (begin
                               (result-of stmt env)
                               (while-loop))
                             'break
                             )))]

        [block-stmt (var vars stmt)
                    (let* ((all-vars (cons var vars))
                           (var-refs (new-ref-list all-vars))
                           (local-env (extend-env* all-vars var-refs env)))
                      (result-of stmt local-env))]
         
        )))


  ;; apply-procedure : Proc * ExpVal -> ExpVal
  ;; Page: 119

  ;; uninstrumented version
  (define apply-procedure
    (lambda (proc1 val)
      (cases proc proc1
        (procedure (var body saved-env)
                   (value-of body
                             (extend-env var (newref val) saved-env))))))

  (define new-ref-list
    (lambda (vars)
      (if(null? vars)
         '()
         [cons (newref 0) (new-ref-list(cdr vars))])))

  (define extend-env*
    (lambda (vars refs old-env)
      ;      (if (or (null? refs) (null? refs))
      ;          [old-env]
      ;          [extend-env (car vars) (car refs)
      ;                      (extend-env* (cdr vars) (cdr refs) old-env)])
      (cond [(or (null? vars) (null? refs))
             old-env]
            [else
             (extend-env (car vars) (car refs) (extend-env* (cdr vars) (cdr refs) old-env))])

      ))

  )

  


  
