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
      [letnumber (digit (arbno digit)) number]
      [letnumber ("-" digit (arbno digit)) number]
      ))
  
  (define the-grammar
    '([program (expression) a-program]

      [expression (letnumber) const-exp]
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
       ("letrec" identifier "(" identifier (arbno "," identifier) ")" "=" expression "in" expression)
       letrec-exp]

;      [expression
;       ("proc" "(" identifier ")" expression)
;       proc-exp]

      [expression
       ("proc" "(" identifier (arbno "," identifier) ")" expression)
       proc-exp]

      [expression
       ( "(" expression (arbno expression) ")" )
       call-exp]

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
