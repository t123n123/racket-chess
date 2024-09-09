#lang racket/gui
(require racket/draw)
(require racket/contract)

(define cell-side 124)
(define window-side (* cell-side 10))

(define frame (new frame% [label "Example"] [width window-side] [height window-side]))
(define canvas (new canvas% [parent frame]))
(define dc (send canvas get-dc))

(define no-pen (make-object pen% "Black" 1 'transparent))
(define no-brush (make-object brush% "Black" 'transparent))
(define blue-brush (make-object brush% "Blue" 'solid))
(define black-brush (make-object brush% "Black" 'solid))
(define white-brush (make-object brush% "White" 'solid))
(define ivory-brush (make-object brush% "Ivory" 'solid))
(define dark-brush (make-object brush% "Cornflower Blue" 'solid))
(define background-brush (make-object brush% (make-object color% 230 220 250) 'solid))

(define (draw-square dc x y brush)
  (send dc set-pen no-pen)
  (send dc set-brush brush)
  (send dc draw-rectangle x y cell-side cell-side))

(define (draw-table dc)
  (send dc set-pen no-pen)
  (send dc set-brush background-brush)
  (send dc draw-rectangle 0 0 window-side window-side)
  (for* ([i '(1 2 3 4 5 6 7 8)]
         [j '(1 2 3 4 5 6 7 8)])
    (draw-square dc (* i cell-side) (* j cell-side) (if (odd? (+ i j)) ivory-brush dark-brush))))

(define pieces
  (list 'none
        'black-rook
        'black-knight
        'black-bishop
        'black-queen
        'black-king
        'black-pawn
        'white-rook
        'white-knight
        'white-bishop
        'white-queen
        'white-king
        'white-pawn))

(define (load-piece-bitmap piece)
  (read-bitmap (string-append "./pieces/" (symbol->string piece) ".png")))

(define initial_board
  (list (list 1 2 3 4 5 3 2 1)
        (list 6 6 6 6 6 6 6 6)
        (list 0 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0 0)
        (list 12 12 12 12 12 12 12 12)
        (list 7 8 9 10 11 9 8 7)))

(define current_board initial_board)

(send frame show #t)
(sleep/yield 0.05)

(draw-table dc)

(for* ([i '(0 1 2 3 4 5 6 7)]
       [j '(0 1 2 3 4 5 6 7)])
  (let ([piece-tag (list-ref pieces (list-ref (list-ref current_board i) j))])
    (if (eq? 'none piece-tag)
        (values)
        (send dc
              draw-bitmap
              (load-piece-bitmap piece-tag)
              (* cell-side (+ j 1))
              (* cell-side (+ i 1))))))

