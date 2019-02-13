;; Nhan Cao
;; CS 380 HW2
#lang eopl

(provide (all-defined-out))

;; Excercise 2.5:
;; empty-env: () -> env
(define empty-env
  (lambda () '()))

;; extend-env: Var x Val x Env -> Env
(define extend-env
  (lambda (var val env)
    (cons (cons var val) env)))


;; Exercise 2.8:
;; empty-env?: Env -> Boolean
(define empty-env?
  (lambda (env)
    (null? env)))

;; has-binding?: Env x Var -> Boolean
(define has-binding?
  (lambda (env search-var)
    (cond
      [(empty-env? env)
       #f]
      [else
       (let ((saved-var (caar env))
             (saved-env (cdr env)))
         (if (eqv? search-var saved-var)
             #t
             (has-binding? saved-env search-var)))])))

;; Exercise 2.10
;; extend-env*: listOf(var) x listOf(val) x env -> env
(define extend-env*
  (lambda (lstVar lstVal env)
    (cond [(or (null? lstVar) (null? lstVal))
           env]
          [else
           (cons (cons (car lstVar) (car lstVal)) (extend-env* (cdr lstVar) (cdr lstVal) env))])))





;;;;;;;;;;;;;;;;;;;;;;;;;
(define apply-env
  (lambda (env search-var)
    (cond
      [(empty-env? env)
       (display "Not here")]
      [else
       (let ((saved-var (caar env))
             (saved-val (cdar env))
             (saved-env (cdr env)))
         (if (eqv? search-var saved-var)
             saved-val
             (apply-env saved-env search-var)))])))

(define e
  (extend-env 'd 6
    (extend-env 'k 7
      (extend-env 'l 3
        (extend-env 'm 5
         (empty-env))))))

(define f
  (extend-env* (list 'b 'c 'g 'h) (list 3 8 0 19) e))

(define i
  (extend-env 'd 6 (empty-env)))

;(apply-env e 'd)

(define a (list (cons 1  2) 4))






