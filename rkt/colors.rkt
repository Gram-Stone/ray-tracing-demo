#lang racket/base

(require racket/class
         racket/draw)

(provide (all-defined-out))

(define-values
  (RED GREEN BLUE BLACK WHITE)
  (values (make-object color% 255 0 0)
          (make-object color% 0 255 0)
          (make-object color% 0 0 255)
          (make-object color% 0 0 0)
          (make-object color% 255 255 255)))

(define BACKGROUND-COLOR BLACK)