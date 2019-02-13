#lang eopl


;; Exercise 2.21
;;
(define-datatype env-exp env-exp?
  (empty-env)
  (a-node
   (item node?))
  (an-env
   (first node?)
   (second env-exp?)))

(define-datatype node node?
  (item
   (var symbol?)
   (val number?)))

;; has-binding?: Env x Var -> Boolean
(define has-binding?
  (lambda (env search-var)
    (cases env-exp env
      (a-node (var)
              (eqv? var search-var))
      (an-env (first second)
              (or
               (eqv? (car first) search-var)
               (has-binding? second search-var)))
      (empty-env #f))))