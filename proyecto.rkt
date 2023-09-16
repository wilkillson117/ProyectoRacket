#lang sketching

(define n 20) ; Default number of circles per row
(define colors '(["white"] ["red"] ["orange"] ["yellow"] ["blue"] ["green"])

(define (setup)
  (size 640 360)
  (frame-rate 60)
  (background 0)
  (no-stroke))

(define (draw)
  (background 0)
  (for ([i (in-range 5)]) ; Loop for 5 rows
    (let ([row-color (list-ref colors i)])
      (fill row-color)
      (draw-row i))))

(define (draw-row row)
  (let ([spacing (/ height 5)] ; Vertical spacing between rows
        [y (+ (* row spacing) (/ spacing 2))]) ; Y-coordinate of each row
    (for ([i (in-range n)]) ; Loop to draw n circles
      (let ([x (+ (* i (/ width n)) (/ (/ width n) 2))) ; X-coordinate of each circle
            [r (random 0 100)]) ; Random radius
        (ellipse x y r r)))))
