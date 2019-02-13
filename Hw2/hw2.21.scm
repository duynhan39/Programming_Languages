#lang eopl
(provide(all-defined-out))

;; Exercise 2.21
;;
(define-datatype env-exp env-exp?
  (empty-env)
  (extend-env
   (var symbol?)
   (val always?)
   (env env-exp?)))


;; has-binding?: Env x Var -> Boolean
(define has-binding?
  (lambda (env search-var)
    (cases env-exp env
      [extend-env (var val env)
                  (or (equal? var search-var)
                      (has-binding? env search-var))]
      [empty-env () #f])))

;; empty-env?: Env -> Boolean
(define empty-env?
  (lambda (env)
    (cases env-exp env
      [empty-env () #t]
      [extend-env (var val env) #f])))


;; apply-env: env x var -> val
(define apply-env
  (lambda (env search-var)
    (cases env-exp env
      [empty-env ()
       (display "No found for ~s" search-var)]
      [extend-env (var val env)
      
         (if (eqv? search-var var)
             val
             (apply-env env search-var))])))

;; extend-env*: listOf(var) x listOf(val) x env -> env
(define extend-env*
  (lambda (lstVar lstVal env)
    (cond [(or (null? lstVar) (null? lstVal))
           env]
          [else
           (extend-env (car lstVar) (car lstVal) (extend-env* (cdr lstVar) (cdr lstVal) env))])))


(define e
  (extend-env 'd 6
    (extend-env 'k 7
      (extend-env 'l 3
        (extend-env 'm 5
         (empty-env))))))

;test
(define f
  (extend-env* (list 'b 'c 'g 'h) (list 3 8 0 19) e))

(define i
  (extend-env 'd 6 (empty-env)))

;(apply-env e 'd)


