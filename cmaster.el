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


;; from http://stackoverflow.com/questions/8549351/c11-mode-or-settings-for-emacs
(defun --copy-face (new-face face)
  "Define NEW-FACE from existing FACE."
  (copy-face face new-face)
  (eval `(defvar ,new-face nil))
  (set new-face new-face))

; labels, case, public, private, proteced, namespace-tags
(--copy-face 'font-lock-label-face 'font-lock-keyword-face)
; comment markups such as Javadoc-tags
(--copy-face 'font-lock-doc-markup-face 'font-lock-doc-face)
; comment markups
(--copy-face 'font-lock-doc-string-face 'font-lock-comment-face)

(add-hook 'c++-mode-hook
      '(lambda()
        (font-lock-add-keywords
         nil '(;; complete some fundamental keywords
           ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>"
            . font-lock-keyword-face)
           ;; add the new C++11 keywords
           ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>"
            . font-lock-keyword-face)
           ("\\<\\(char[0-9]+_t\\)\\>" . font-lock-keyword-face)
           ;; user-types (customize!)
           ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(t\\|type\\|ptr\\)\\>" . font-lock-type-face)
           ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
           ))
        ) t)
