;; display initialization settings (namely disable the default X11 settings)
(setq inhibit-x-resources t)
(require 'linum) ; line numbers
(when (featurep 'linum) (global-linum-mode 1))
;; taken from http://www.emacswiki.org/LineNumbers
(setq linum-disabled-modes
      '(eshell-mode term-mode magit-mode compilation-mode comint-mode
                    inferior-scheme-mode geiser-repl-mode))
(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes))
    (linum-mode 1)))

;; Other display stuff
(column-number-mode t)
(require 'highlight-parentheses)
(defun turn-on-highlight-parentheses-mode ()
  "Enable highlight parentheses mode in the current buffer."
  (highlight-parentheses-mode t))

(define-globalized-minor-mode global-highlight-parentheses-mode
   highlight-parentheses-mode turn-on-highlight-parentheses-mode
  "Global mode to highlight parentheses.")
(global-highlight-parentheses-mode t)
(setq hl-paren-colors
      '("firebrick1" "IndianRed1" "IndianRed3" "IndianRed4"))

;; color theme stuff
(require 'color-theme)
(color-theme-initialize)
(color-theme-comidia)
(if (not (boundp 'aquamacs-version))
    (set-face-attribute 'default nil
                        :family "Monospace" :height 110))
(custom-set-faces
 '(term-color-blue ((t (:foreground "DodgerBlue1"))))
 '(mode-line ((t (:background "dim gray" :foreground "black" :box
                              (:line-width -1 :style released-button))))))
(setq font-lock)
(set-face-background 'highlight "grey20") ;; override nasty green color
(set-face-foreground 'minibuffer-prompt "thistle1")
(set-face-foreground 'font-lock-negation-char-face "red")


;; colors for magit
(add-hook 'magit-mode-hook
          (lambda ()
            (set-face-background 'magit-diff-hunk-header "grey26")
            (set-face-background 'magit-item-highlight "grey20")))

;; modify the syntax highlighting if in gui mode
(add-hook 'prog-mode-hook
          (lambda ()
            (if (display-graphic-p)
                (progn
                  (set-face-background 'default "grey12")
                  (make-face-italic 'font-lock-comment-face)
                  (set-face-foreground 'font-lock-comment-face "orange")
                  nil))))
