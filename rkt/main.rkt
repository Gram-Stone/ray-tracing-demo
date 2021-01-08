#lang racket/base

(require racket/class
         racket/gui/base
         racket/list
         "colors.rkt"
         "constants.rkt"
         "math.rkt"
         "scene.rkt"
         "sphere.rkt"
         "toplevel.rkt")

(provide main)

;;main function
(define (main)
  (new canvas%
       [parent f]
       [paint-callback (λ (canvas dc)
                         (send dc set-origin (/ cw 2) (/ ch 2))
                         (for ([i (in-range (- (/ cw 2)) (/ cw 2))])
                           (for ([j (in-range (- (/ ch 2)) (/ ch 2))])
                             (send* dc
                               (set-pen (send the-pen-list find-or-create-pen (trace-ray O (canvas->viewport i j) 1 +inf.0) 2 'solid))
                               (draw-point i j)))))])
  (send f show #t))

;;converts canvas coordinates to viewport coordinates
(define (canvas->viewport x y)
  (list (* x (/ vw cw))
        (- (* y (/ vh ch)))
        d))

;;computes intersection(s) of ray with spheres, if one exists
(define (intersect-ray-sphere O D sphere)
  (define C (sphere-center sphere))
  (define r (sphere-radius sphere))
  (define OC (list- O C))
  (define k1 (dot-product D D))
  (define k2 (* 2 (dot-product OC D)))
  (define k3 (- (dot-product OC OC) (* r r)))
  (define disc (discriminant k1 k2 k3))
  (if (negative? disc)
      (values +inf.0 +inf.0)
      (values (/ (+ (- k2) (sqrt disc)) (* 2 k1))
              (/ (- (- k2) (sqrt disc)) (* 2 k1)))))

;;computes the intersection of ray with every sphere and returns the color of the sphere at the nearest intersection inside the requested range of t
(define (trace-ray O D t-min t-max)
  (define closest-t +inf.0)
  (define closest-sphere (void))
  (for-each (λ (sphere)
              (define-values (t1 t2) (intersect-ray-sphere O D sphere))
              (when (and (and (> t1 t-min) (< t1 t-max)) (< t1 closest-t))
                (set! closest-t t1)
                (set! closest-sphere sphere))
              (when (and (and (> t2 t-min) (< t2 t-max)) (< t2 closest-t))
                (set! closest-t t2)
                (set! closest-sphere sphere)))
            scene)
  (if (void? closest-sphere)
      BACKGROUND-COLOR
      (sphere-color closest-sphere)))