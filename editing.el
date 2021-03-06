(global-set-key (kbd "RET") 'newline-and-indent)
(setq require-final-newline t)
(add-hook 'flyspell-mode-hook (lambda () (setq flyspell-issue-message-flag nil)))

;; settings for evil
(require 'undo-tree)
(require 'evil)
(evil-mode 1)
(setq evil-shift-width 4) ; fix behavior of > and < in normal state.
(setq evil-repeat-move-cursor nil) ; on the . command do not move cursor
(setq evil-emacs-state-modes (cons 'ansi-term-mode evil-emacs-state-modes))

;; surround-mode
(require 'surround)
(global-surround-mode 1)

; bind window switching to something that will not give me carpal tunnel.
(defun cycle-selected-buffer () 'cycle-selected-buffer)
(define-key evil-normal-state-map "tn" 'other-window)

(with-demoted-errors
  (progn
    (require 'yasnippet)
    (yas-global-mode 1)
    (yas-load-directory
     "~/.emacs.d/plugins/yasnippet-snippets/snippets/text-mode")
    (setq yas-indent-line 'auto)))

(add-hook 'term-mode-hook (lambda () (setq yas-dont-activate t)))

(setq yas-snippet-dirs
      (cons "~/.emacs.d/plugins/yasnippet-snippets/snippets/text-mode"
            yas-snippet-dirs))

(require 'smartparens)
(smartparens-global-mode t)
(setq sp-highlight-pair-overlay nil) ; turn off nasty green color thing
; remove single-quotes (for lisp programming). Maybe turn it on again for other
; modes? (not matlab)
(sp-pair "'" nil :actions :rem)
(sp-pair "`" nil :actions :rem)
(setq sp-cancel-autoskip-on-backward-movement nil)

;; start server mode (mainly so that I can edit files from the shell without
;; using vim inside emacs)
(server-start)

;; Unfortunately, flyspell-prog-mode will only check the portion of the buffer
;; that it knows are comments or strings, which is limited to the surrounding
;; 500 characters (about one screen's worth of text). To get around this,
;; highlight the whole buffer before doing any syntax highlighting and then
;; reset the value.
(defun spell-check-with-fontify ()
  "Spell check the whole buffer with fontification"
  (interactive)
  (let ((previous-chunk-size jit-lock-chunk-size))
    (save-excursion
      (setq jit-lock-chunk-size (point-max))
      (font-lock-default-fontify-region (point-min) (point-max) nil)
      (flyspell-buffer)
      (setq jit-lock-chunk-size previous-chunk-size))))
