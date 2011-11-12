;;
;;  guess.scm - Guessing game in PLT Scheme
;;
;;  This is written to demonstrate this language versus the same program
;;  written in other languages.

;; 7-Jul-2005	Jepri	Initial creation
;;
;; Runs under plt scheme, possibly others as well
;; Lines are longer than 80 chars because in the future, we will all have 160-char monitors *and* 640 Kb of RAM

(require (lib "27.ss" "srfi"))
(random-source-randomize! default-random-source)



; Print high scores
(define show-old-scores
  (lambda ()
    (display (format "Previous high scores:~n"))
    (with-input-from-file "highscores_scm" 
      (lambda () (display-file (current-input-port))))
    (exit)))

(define display-file
  (lambda (port)
    (let ((line (read-line port)))
      (if (not (eof-object? line))
          (begin (display (format "~a~n" line)) (display-file port))))))


; Save high score
(define record-score
  (lambda (score)
    (display (format "Correct!  That took ~a guesses~n" score))
    (display  "Please enter your name:" )
    (let ((name (read-line)))
      (let (( port (open-output-file "highscores_scm" 'append)))
        (display (format "~a ~a~n" name score) port )
        (close-output-port port)
        (show-old-scores)))))


(define higher-or-lower
  (lambda (guess answer)
    (if (< guess answer)
        (format "Higher....~n")
        (format "Lower....~n"))))

(define play 
  (lambda (answer num-of-guesses)
    (display (format "Enter guess ~a:" num-of-guesses))
    (let ((guess (read-line)))
      (if (equal? answer (string->number guess))
          (record-score num-of-guesses)
          (begin 
            (display (higher-or-lower (string->number guess)  answer)) 
            (play answer (add1 num-of-guesses)))))))



; Generate random number
; Play the game

(play (add1 (random-integer 99)) 1)
