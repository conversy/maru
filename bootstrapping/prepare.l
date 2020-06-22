;;; -*- mode: lisp; coding: us-ascii -*-

(warn "--- boostrapping: prepare\n")

(let ((host-module (current-module))
      (slave-module (create-module)))
  (define slave slave-module)
  (define-function switch-to-slave-module ()
    ;;(warn "--- switching to the slave module\n")
    (set (current-module) slave))
  (switch-to-slave-module)
  ;; in the slave, set the global variable called 'host' to hold the host-module
  (eval-in-module slave (list (string->symbol "define")
                              (string->symbol "host")
                              host-module)))

;; NOTE: we are in the slave module now, and the following forms will be read/interned into the slave.
;; NOTE: the slave module doesn't have boot.l loaded at this point, we only have the primitives.

(define switch-to-host-module
    (lambda ()
      ;;(warn "--- switching to the host  module\n")
      (set (current-module) host)))

(switch-to-host-module)