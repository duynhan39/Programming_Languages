#lang eopl

(define-datatype s-list s-list?
  [empty-s-list]
  [non-empty-s-list (first symbol?)
                    (second s-list?)])


(empty-s-list)

(non-empty-s-list 'a (empty-s-list))