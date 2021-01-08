#lang racket/base

(require racket/class
         racket/gui/base
         "constants.rkt")

(provide f)

(define f (new frame%
               [label "Ray Tracing Demo"]
               [width cw]
               [height ch]))