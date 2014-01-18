;; file to execute under darwin.
(if (boundp 'aquamacs-version)
  (progn
    (tabbar-mode -1)
    (setq aquamacs-autoface-mode nil)
    (setq aquamacs-save-options-on-quit nil)
    (setq aquamacs-scratch-file nil
          initial-major-mode 'lisp-interaction-mode))
  (progn
    (set-default-font (concat "-apple-bitstream vera sans mono-medium-r-normal-"
                              "-12-120-72-72-m-120-iso10646-1"))))

(setq haskell-program-name "/sw/bin/ghci")
(setq-default inferior-lisp-program "/sw/bin/sbcl")
(setq python-python-command "/Users/drwells/Applications/python")

(set-face-attribute 'default nil :height 130)

; Yegge's suggestion
(global-set-key "\C-x\C-m" 'execute-extended-command)
