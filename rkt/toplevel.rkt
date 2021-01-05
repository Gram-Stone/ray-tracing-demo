#lang racket/base

(require racket/class
         racket/gui/base
         "constants.rkt")

(provide f)

(define f (new frame%
               [label "Raytracing Demo"]
               [width cw]
               [height ch]))