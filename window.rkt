#lang racket/gui
(require racket/draw)
(require racket/contract)
(require "state.rkt")
(require "gui.rkt")
(require "game.rkt")
(require "piece.rkt")

(define window (new chess-window%))
(define game (new chess-game%))

(send window show)
(sleep/yield 0.2)
(send window draw-table ivory-brush dark-brush)

(for* ([i '(0 1 2 3 4 5 6 7)]
       [j '(0 1 2 3 4 5 6 7)])
  (let ([piece-tag (send game get-piece-at i j)])
    (if (eq? 'none piece-tag)
        (values)
        (send window draw-piece (get-piece-bitmap piece-tag) j i))))

(sleep/yield 1.5)

