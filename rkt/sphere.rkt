#lang racket/base

(provide (struct-out sphere))

(struct sphere (center
                radius
                color))