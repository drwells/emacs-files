(global-set-key (kbd "RET") 'newline-and-indent)

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
