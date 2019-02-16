(module lang

  ;; grammar for the LET language

  (lib "eopl.ss" "eopl")                
  
  (require "drscheme-init.scm")
  
  (provide (all-defined-out))

  ;;;;;;;;;;;;;;;; grammatical specification ;;;;;;;;;;;;;;;;
  
  (define the-lexical-spec
    '([whitespace (whitespace) skip]
      [comment ("%" (arbno (not #\newline))) skip]
      [identifier
       (letter (arbno (or letter digit "_" "-" "?")))
       symbol]
      [number (digit (arbno digit)) number]
      [number ("-" digit (arbno digit)) number]
      ;[bool ((or "#t" "#f")) bool]
      ))
  
  (define the-grammar
    '([program (expression) a-program]

      [expression (number) const-exp]
      [expression
       ("-" "(" expression "," expression ")")
       diff-exp]
      
      [expression
       ("zero?" "(" expression ")")
       zero?-exp]

      [expression
       ("if" expression "then" expression "else" expression)
       if-exp]

      [expression (identifier) var-exp]

      [expression
       ("let" identifier "=" expression "in" expression)
       let-exp]

      [expression
       ("minus" "(" expression ")")
       minus]
      
      [expression
       ("+" "(" expression "," expression ")")
       add-exp]

      [expression
       ("*" "(" expression "," expression ")")
       mul-exp]

      [expression
       ("/" "(" expression "," expression ")")
       quotient-exp]

      [expression
       ("equal?" "(" expression "," expression ")")
       equal?-exp]

      [expression
       ("greater?" "(" expression "," expression ")")
       greater?-exp]

      [expression
       ("less?" "(" expression "," expression ")")
       less?-exp]

      [expression
       ("#t")
       const-true]

      [expression
       ("#f")
       const-false]
      
      [expression
       ("cond" (arbno expression "==>" expression) "end" )
       cond-exp]

      [expression
       ("print" "(" expression ")")
       print-exp]

      ))
  
  ;;;;;;;;;;;;;;;; sllgen boilerplate ;;;;;;;;;;;;;;;;
  
  (sllgen:make-define-datatypes the-lexical-spec the-grammar)
  
  (define (show-the-datatypes)
    (sllgen:list-define-datatypes the-lexical-spec the-grammar))
  
  (define scan&parse
    (sllgen:make-string-parser the-lexical-spec the-grammar))
  
  (define just-scan
    (sllgen:make-string-scanner the-lexical-spec the-grammar))
  
  )
