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

;;array of pixel locations
(define c (my-cartesian-product (range (/ (- cw) 2) (/ cw 2))
                                (range (/ (- ch) 2) (/ ch 2))))

;;converts canvas coordinates to viewport coordinates
(define (canvas->viewport cx cy)
  (list (* cx (/ vw cw))
        (* cy (/ vh ch))
        d))

;;converts canvas coordinates to canvas% coordinates
(define (canvas->canvas% cx cy)
  (cons (+ (/ cw 2) cx)
        (- (/ ch 2) cy)))

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

(define (main)
  (new canvas%
       [parent f]
       [paint-callback
        (λ (canvas dc)
          (for-each (λ (x)
                      (define D (canvas->viewport (car x) (cdr x)))
                      (send* dc
                        (set-pen (send the-pen-list
                                       find-or-create-pen
                                       (trace-ray O
                                                  D
                                                  1
                                                  +inf.0)
                                       2
                                       'solid))
                        (draw-point (car (canvas->canvas% (car x) (cdr x))) (cdr (canvas->canvas% (car x) (cdr x))))))
                    c))])
  (send f show #t))