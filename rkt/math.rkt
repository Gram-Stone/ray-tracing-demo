#lang racket/base

(require racket/math)

(provide (all-defined-out))

(define (discriminant a b c)
  (- (sqr b) (* 4 a c)))

(define (dot-product lst1 lst2)
  (apply + (map * lst1 lst2)))

(define (v-length v)
  (sqrt (dot-product v v)))

(define (list+ lst1 lst2)
  (map + lst1 lst2))

(define (list- lst1 lst2)
  (map - lst1 lst2))

(define (scalar-multiplication k v)
  (for/list ([i v])
    (* i k)))