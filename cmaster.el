(setq c-default-style
      '((c-mode . "linux")
        (c++-mode . "gnu")))
(setq c-basic-offset 8)

; fix behavior of > and < in normal state.
(set (make-local-variable 'evil-shift-width) 8)

(add-hook 'c++-mode-hook (lambda () (setq c-basic-offset 2)))

(defun add-order-macro (start end)
  "Convert some pair 1, 2 to ORDER(1, 2, entriesPerRow, entriesPerCol)"
  (defun decrement-string (integer-string)
    (number-to-string (- (parse-integer integer-string) 1)))
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char start)
    (replace-regexp "\\([0-9]+\\),\\([0-9]+\\)"
                    "ORDER(\\1, \\2, entriesPerRow, entriesPerCol)")))
