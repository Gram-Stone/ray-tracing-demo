#lang racket/base

(provide (struct-out ambient-light)
         (struct-out point-light)
         (struct-out directional-light))

(struct ambient-light (intensity))
(struct point-light (intensity position))
(struct directional-light (intensity direction))