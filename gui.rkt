#lang racket/gui

(require racket/draw)
(require racket/contract)
(require "piece.rkt")

(provide chess-window% no-pen no-brush ivory-brush dark-brush background-brush)

(define chess-canvas%
  (class canvas%
    (define/override (on-event event)
      (
       (when (send event get-left-down)
         (printf "Mouse clicked at: ~a, ~a\n"
                 (send event get-x)
                 (send event get-y)))

       (when ((or/c 'motion) (send event get-event-type))
         (printf "Mouse moved to: ~a, ~a\n"
                 (send event get-x)
                 (send event get-y)))))



    (super-new)))




(define chess-window%
  (class object%
    (public draw-table show draw-piece close)
    (super-new)
    (field (cell-size 124))
    (field (window-side (* cell-size 10)))
    (field (frame (new frame%
                       [label "Example"]
                       [width window-side]
                       [height window-side])))

    (field (canvas (new chess-canvas% [parent frame])))
    (field (dc (send canvas get-dc)))

    (define (show) (send frame show #t))
    (define (close) (send frame show #f))

    (define (draw-square x y brush)
      (send dc set-pen no-pen)
      (send dc set-brush brush)
      (send dc draw-rectangle x y cell-size cell-size))

    (define (draw-table light-brush dark-brush)
      (send dc set-pen no-pen)
      (send dc set-brush background-brush)
      (send dc draw-rectangle 0 0 window-side window-side)
      (for* ([i '(1 2 3 4 5 6 7 8)]
             [j '(1 2 3 4 5 6 7 8)])
        (draw-square (* i cell-size) (* j cell-size) (if (odd? (+ i j)) light-brush dark-brush))))

    (define (draw-piece bitmap i j)
      (send dc
            draw-bitmap
            bitmap
            (* cell-size (+ j 1))
            (* cell-size (+ i 1))))))





(define no-pen (make-object pen% "Black" 1 'transparent))
(define no-brush (make-object brush% "Black" 'transparent))
(define ivory-brush (make-object brush% "Ivory" 'solid))
(define dark-brush (make-object brush% "Cornflower Blue" 'solid))
(define background-brush (make-object brush% (make-object color% 230 220 250) 'solid))


