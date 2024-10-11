#lang racket


#|
**Exercise 2.39:** Complete the following
definitions of `reverse` (Exercise 2.18) in terms of
`fold-right` and `fold-left` from Exercise 2.38.

```
(define (reverse sequence)
  (fold-right 
   (lambda (x y) ⟨??⟩) nil sequence))

(define (reverse sequence)
  (fold-left 
   (lambda (x y) ⟨??⟩) nil sequence))
```

|#




(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define (fold-right op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op (car rest) result)
              (cdr rest))))
  (iter initial (reverse sequence)))


(define (reverse1 sequence)
  (fold-right 
   (lambda (x y)  (append y (list x))) null sequence))


(define (reverse2 sequence)
  (fold-left 
   (lambda (x y) (cons y x)) null sequence))

(reverse1 (list 1 2 3))

#|

(reverse1 (list 1 2 3))
  
  (fold-right 
    (lambda (x y)  (append y (list x))) null sequence)

  (fold-right op initial sequence)
 
  (fold-right (lambda (x y)  (append y (list x))) null (list 1 2 3))

  (iter initial (reverse sequence))

  (iter null (reverse (list 1 2 3)))

  (iter null (list 3 2 1))

  (iter result rest)

   (if (null? rest)
        result
        (iter (op (car rest) result)
              (cdr rest)))
   
   (if (null? (list 3 2 1))
        result
        (iter (op (car rest) result)
              (cdr rest)))

   (iter ( (lambda (x y)  (append y (list x))) (car (list 3 2 1) null ) )
              (cdr (list 3 2 1)) )

   (iter ( (lambda (x y)  (append y (list x))) 3 null)
              (2 1) )

   (iter (  (lambda (x y)  (append y (list x)))  2 ( (lambda (x y)  (append y (list x))) 3 null) )
              (1) )

   (iter ( (lambda (x y)  (append y (list x)))  1 ((lambda (x y)  (append y (list x)))  2 ( (lambda (x y)  (append y (list x))) 3 null)))
              () )
    
   (if (null? ())
        result
        (iter (op (car rest) result)
              (cdr rest)))

    result

    ( (lambda (x y)  (append y (list x)))  1 ((lambda (x y)  (append y (list x)))  2 ( (lambda (x y)  (append y (list x))) 3 null)))

    (   (lambda (x y)  (append y (list x))) 1 ( (lambda (x y)  (append y (list x))) 2 (list 3) ))
   
    
      ((lambda (x y)  (append y (list x)))  1 (list 3 2) )

      (append (list 3 2) (list 1))


    (3 2 1)

  
|#



(reverse2 (list 1 2 3))


#|

(reverse2 (list 1 2 3))
  
  (fold-right 
    (lambda (x y) (cons y x)) null sequence)

  (fold-right op initial sequence)
 
  (fold-right (lambda (x y) (cons y x)) null (list 1 2 3))

  (iter initial sequence)

  (iter nul (list 1 2 3))

  (iter null (list 1 2 3))

  (iter result rest)

   (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest)))
   
   (if (null? (list 1 2 3))
        result
        (iter (op result (car rest))
              (cdr rest)))

   (iter ( (lambda (x y) (cons y x))  null (car (list 1 2 3) ) )
              (cdr (list 1 2 3)) )

   (iter ( (lambda (x y) (cons y x)) null 1)
              (2 3) )

   (iter (  (lambda (x y) (cons y x))  ( (lambda (x y) (cons y x)) null 1) 2  )
              (3) )

   (iter ( (lambda (x y) (cons y x))  (  (lambda (x y) (cons y x))  ( (lambda (x y) (cons y x)) null 1) 2) 3)
              () )
    
   (if (null? ())
        result
        (iter (op result (car rest))
              (cdr rest)))

    result

    ( (lambda (x y) (cons y x))  (  (lambda (x y) (cons y x))  ( (lambda (x y) (cons y x)) null 1) 2) 3)

    ( (lambda (x y) (cons y x))  (  (lambda (x y) (cons y x)) (cons 1 null) 2) 3)
   
    
     ( (lambda (x y) (cons y x))  (cons 2(cons 1 null)) 3)

     (cons 3 (cons 2 (cons 1 null)))


    (3 2 1)

  
|#


