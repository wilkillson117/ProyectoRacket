#lang sketching

(define n 40)
(define ancho-ventana 640)
(define alto-ventana 360)
(define alto-barra (* alto-ventana 0.7)) ; 70% del alto de la ventana
(define mitad (/ ancho-ventana 2))

(define valores-iniciales (build-list n (lambda (_) (random 1 (floor alto-barra)))))
(define valores (append valores-iniciales valores-iniciales))

(define (list-copy lst)
  (if (null? lst) '() (cons (car lst) (list-copy (cdr lst)))))

(define i 0)
(define j 0)
(define contador 0)
(define ancho-barra (/ ancho-ventana (* 2 n)))

(define (list-set lst idx val)
  (map (lambda (item i) (if (= i idx) val item))
       lst
       (let loop ([i 0] [res '()])
         (if (= i (length lst)) (reverse res) (loop (+ i 1) (cons i res))))))

(define (draw-values valores)
  (let loop ([indice 0])
    (when (< indice (* 2 n))
      (define valor (list-ref valores indice))
      (define x (* indice ancho-barra))
      (define y (- alto-ventana valor))
      (if (< x mitad)
          (fill 0 0 200) ; Azul
          (fill 200 0 0)) ; Rojo
      (rect x y ancho-barra valor)
      (loop (+ indice 1)))))

(define (bubble-sort-step valores)
  (let ([limit (floor (/ mitad ancho-barra))])
    (cond
      [(>= i limit) valores]
      [(>= j (- limit i 1))
       (set! i (+ i 1))
       (set! j 0)
       valores]
      [(> (list-ref valores j) (list-ref valores (+ j 1)))
       (set! valores (list-set (list-set valores j (list-ref valores (+ j 1))) (+ j 1) (list-ref valores j)))
       (set! j (+ j 1))
       (set! contador (+ contador 1))
       valores]
      [else
       (set! j (+ j 1))
       (set! contador (+ contador 1))
       valores])))

(define (draw)
  (background 0)
  
  ; Leyendas y cuadros de color
  (fill 0 0 200) ; Azul
  (rect 5 45 20 20)
  (fill 255)
  (text "Bubble-sort" 30 45)
  
  (fill 200 0 0) ; Rojo
  (rect 5 75 20 20)
  (fill 255)
  (text "Original" 30 75)
  
  ; Mover Contador a la esquina superior derecha
  (fill 255 255 255)
  (text (string-append "Contador: " (number->string contador)) (- ancho-ventana 120) 20)

  
  (draw-values valores)
  
  (set! valores (bubble-sort-step valores)))



(define (setup)
  (size ancho-ventana alto-ventana)
  (frame-rate 200)
  (color-mode 'rgb)
  (background 0))

(setup)
