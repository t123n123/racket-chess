#lang racket/base

(require racket/class)
(require racket/list)
(require "piece.rkt")

(provide initial_board chess-game%)

(define initial_board
  (list (list 1 2 3 4 5 3 2 1)
        (list 6 6 6 6 6 6 6 6)
        (list 0 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0 0)
        (list 0 0 0 0 0 0 0 0)
        (list 12 12 12 12 12 12 12 12)
        (list 7 8 9 10 11 9 8 7)))

(define chess-game%
  (class object%
    (public reset-game get-piece-at)
    (super-new)
    (field (game-board initial_board))

    (define (get-piece-id-at x y)
      (list-ref (list-ref game-board y) x))

    (define (get-piece-at x y)
      (idx->piece (get-piece-id-at x y)))

    (define (reset-game) (set! game-board initial_board))

    (define (move-piece sx sy dx dy)
      (list-set (list-ref game-board dy) dx (get-piece-id-at sx sy))
      (list-set (list-ref game-board sy) sx 0))))

