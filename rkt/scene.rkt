#lang racket/base

(provide (struct-out scene))

(struct scene (viewport-width
               viewport-height
               projection-plane-distance
               objects
               lights))