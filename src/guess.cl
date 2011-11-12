#!/usr/local/bin/clisp
;;;
;;; guess.cl - guessing game in common lisp
;;; This is written to demonstrate this language versus the same program
;;; written in other languages.
;;;
;;; 26-Nov-2005 Bruce Woodward  1st Edition.

(defconstant scorefile "highscores_cl")

(format t "guess.cl - Guess a number between 1 and 100~%~%")

(defun prompt-read (prompt)
  (princ prompt)
  (read-line))

(defun read-num (num)
  (read-from-string (prompt-read (format nil "Enter guess ~A:" num))))

(defun read-your-name ()
  (prompt-read (format nil "Please enter your name: ")))

(let* ((answer (+ 1 (random 100 (make-random-state t))));generate random number
       (num 
	(do* ((num 1 (+ num 1))
	      (guess  (read-num num) (read-num num)))
	     ((= answer guess) num)
	     (cond ((< guess answer) (format t "Higher...~%"))
		   ((> guess answer) (format t "Lower...~%"))
		   (t (princ "Should never get here"))))))
  (format t "Currect! That took ~A guesses.~%~%" num)
  ;; save high score
  (let ((name (read-your-name)))
    (with-open-file (file scorefile :direction :output :if-exists :append
			  :if-does-not-exist :create)
		    (write-line (format nil "~A ~A" name num) file)))
  ;; print previous scores
  (with-open-file (file scorefile)
     (do ((line (read-line file nil 'eof)
		(read-line file nil 'eof)))
	 ((eql line 'eof))
	(format t "~A~%" line))))
