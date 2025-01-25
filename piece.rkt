#lang racket/base

(require racket/list)
(require racket/draw)

(define piece-names
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

(define idx->piece-map (make-immutable-hash (map cons (range (length piece-names)) piece-names)))
(define piece->idx-map (make-immutable-hash (map cons piece-names (range (length piece-names)))))

(define (idx->piece idx)
  (hash-ref idx->piece-map idx 'none))

(define (piece->idx piece)
  (hash-ref piece->idx-map piece 0))

(define (get-piece-bitmap piece)
  (read-bitmap(string-append "./pieces/" (symbol->string piece) ".png")))

(provide idx->piece piece->idx get-piece-bitmap)
