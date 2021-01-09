#lang racket/base

(require "colors.rkt"
         "light.rkt"
         "scene.rkt"
         "sphere.rkt")

(provide my-scene)

(define my-scene (scene 1
                        1
                        1
                        (list (sphere (list 0 -1 3) 1 RED)
                              (sphere (list 2 0 4) 1 BLUE)
                              (sphere (list -2 0 4) 1 GREEN)
                              (sphere (list 0 -5001 0) 5000 YELLOW))
                        (list (ambient-light 0.2)
                              (point-light 0.6 (list 2 1 0))
                              (directional-light 0.2 (list 1 4 4)))))