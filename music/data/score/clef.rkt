#lang agile

(require "../time/time-period.rkt")

;; ------------------------------------------------------------------------

(provide clef clef?
         clef-type clef-type->sign+line
         TREBLE-CLEF
         BASS-CLEF
         ALTO-CLEF
         clef-shift-octave)

;; A ClefType is one of
;;  - (treble)
;;  - (bass)
;;  - (alto)
(struct treble [])
(struct bass [])
(struct alto [])

(define TREBLE (treble))
(define BASS (bass))
(define ALTO (alto))

;; clef-type->sign+line : ClefType -> (values String Nat)
(define (clef-type->sign+line ct)
  (match ct
    [(treble) (values "G" 2)]
    [(bass) (values "F" 4)]
    [(alto) (values "C" 3)]))

;; A Clef is a (clef ClefType)
;; TODO: handle offset versions, such as the tenor clef
(struct clef [type octave] #:transparent)

(define TREBLE-CLEF (clef TREBLE 0))
(define BASS-CLEF (clef BASS 0))
(define ALTO-CLEF (clef ALTO 0))

(define (clef-shift-octave c ∆oct)
  (cond
    [(zero? ∆oct) c]
    [else
     (struct-copy clef c [octave (+ (clef-octave c) ∆oct)])]))

;; ------------------------------------------------------------------------

(provide clef-there?)

;; A ClefThere is a [Timed Clef]

;; clef-there? : Any -> Bool
(define (clef-there? v)
  (and (timed? v) (clef? (timed-value v))))

;; ------------------------------------------------------------------------
