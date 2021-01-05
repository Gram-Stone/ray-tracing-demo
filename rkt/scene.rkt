#lang racket/base

(require "colors.rkt"
         "sphere.rkt")

(provide (all-defined-out))

(define vw 1)
(define vh 1)
(define d 1)

(define sphere1 (sphere (list 0 -1 3) 1 RED))
(define sphere2 (sphere (list 2 0 4) 1 BLUE))
(define sphere3 (sphere (list -2 0 4) 1 GREEN))

(define scene
  (list sphere1
        sphere2
        sphere3))