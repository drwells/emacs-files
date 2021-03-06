;;----------------------------------------------------------------------------
;; my .emacs file!! yaaaay
;;----------------------------------------------------------------------------
;; remember - to reload, do M-x load-file <enter> <enter> (default name is
;; current file)
;;----------------------------------------------------------------------------

(require 'package)
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/"))
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(setq default-directory "~/")
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)       ;; instead of yes-or-no do y-or-n
(setq inhibit-startup-message t)    ;; turn off splash screen
(show-paren-mode t)                 ;; show matching parenthesis
(setq-default indent-tabs-mode nil) ;; these four set tabs to 4 spaces
(setq-default tab-width 4)
(global-font-lock-mode t)           ;; these three turn on syntax highlighting
(load-library "font-lock")
(setq font-lock-maximum-decoration t)
;; fix comments
(require 'newcomment)
;; make the font size right.
(set-face-attribute 'default nil :height 115)

;; move between windows with SHIFT + arrow keys instead of C-o
(if (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)
  (message "windmove not found"))

;; Pagewise formatting
(add-hook 'text-mode-hook 'auto-fill-mode) ;; wrap long lines.
;; turn on automatic line wrapping at 79 - because it is 1980 and I am clearly
;; using a teletype.
(setq-default fill-column 80)
(setq fill-column 80)

;; delete whitespace when exiting
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; load plugins.
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))
(load "~/.emacs.d/display.el")
(load "~/.emacs.d/editing.el")

;;
;; mode-specific settings.
;;

;; ansi-term stuff
(setq explicit-shell-file-name "/bin/zsh")

;; see
;; http://stackoverflow.com/questions/6820051/unicode-characters-in-emacs-term-mode
(defadvice ansi-term (after advise-ansi-term-coding-system)
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-activate 'ansi-term)
(setq term-buffer-maximum-size 8192)

;; C stuff
(load-file "~/.emacs.d/cmaster.el")
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; company mode
(eval-after-load 'company '(add-to-list 'company-backends 'company-irony))
(eval-after-load 'company '(setq company-idle-delay 0.1))

;; CMake
(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

;; comint-mode stuff
(add-hook 'comint-output-filter-functions
          'comint-truncate-buffer)

;; D stuff
(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(add-to-list 'auto-mode-alist '("/*.\.d$" . d-mode))

;; desktop mode (reopen buffers when restarting emacs)
(desktop-save-mode 1)

;; dired stuff
(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files "\\|" "\\.pyc$"))

;; eshell stuff
(add-hook 'eshell-mode-hook (lambda () (smartparens-mode t)))

;; GDB
(setq gdb-display-io-nopopup t) ;; disable the popup window

;; Haskell stuff
(setq auto-mode-alist (append '(("/*.\.hs$" . haskell-mode)) auto-mode-alist))
(setq haskell-program-name "/usr/bin/ghci")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(require 'inf-haskell)

;; ido mode
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-file-extensions-order '(".c" ".org" ".el"))
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
;; don't switch frames when I want to view the same buffer in two places; see
;; http://stackoverflow.com/questions/3217247/
;; for more information.
(setq ido-default-buffer-method 'selected-window)


;; LaTeX stuff
(require 'vtex-mode "~/.emacs.d/vtex.el" nil)
(add-to-list 'auto-mode-alist '("/*.\.tex$" . vtex-mode))
(add-hook 'vtex-mode-hook
          (lambda ()
            (progn
              (load-file "~/.emacs.d/latexmaster.el")
              (outline-minor-mode)
              nil)))
(setq vtex-enable-align-continuation nil)
(setq vtex-enable-delete-trailing-whitespace nil)

;; magit stuff
(eval-after-load 'magit
  '(progn
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black")
       (set-face-background 'smerge-refined-added "#194D2C")
       (set-face-background 'smerge-refined-removed "#6E2424"))))
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")

;; markdown stuff
(add-to-list 'auto-mode-alist '("/*.\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("/*.\.markdown$" . markdown-mode))

;; matlab stuff
(setq auto-mode-alist (delete '("\\.m$" . matlab-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-hook 'octave-mode-hook (lambda ()
                              (progn
                                (load-file "~/.emacs.d/matlabmaster.el")
                                nil)))
;; nimrod stuff
(autoload 'nimrod-mode "nimrod-mode" "Major mode for editing Nimrod code." t)
(add-to-list 'auto-mode-alist '("/*.\\.nim$" . nimrod-mode))

;; org-mode stuff
(add-hook 'org-mode-hook
          (lambda ()
              (load-file "~/.emacs.d/orgmaster.el")))
(add-hook 'outline-minor-mode-hook
          (lambda ()
            (define-key outline-minor-mode-map [(shift tab)] 'org-cycle)))

;; prm-mode
(require 'prm-mode "~/.emacs.d/prm-mode.el" nil)
(add-to-list 'auto-mode-alist '("/*.\.prm$" . prm-mode))

;; Python stuff
(add-to-list 'auto-mode-alist '("/*.\.sage" . python-mode))
(add-to-list 'auto-mode-alist '("/*.\.pyx" . python-mode))
(add-to-list 'auto-mode-alist '("/*.\.pxi" . python-mode))
(add-to-list 'auto-mode-alist '("/*.\.pxd" . python-mode))
(add-hook 'python-mode-hook
          (lambda () (load-file "~/.emacs.d/pythonmaster.el")))

;; Scheme stuff
(setq scheme-program-name "guile --fresh-auto-compile --no-debug")
(add-hook 'cmuscheme-load-hook
          (lambda () (load-file "~/.emacs.d/schememaster.el")))

;; smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; tramp
(setq tramp-default-method "ssh")

;; stuff for aquamacs. Ensure that this is the last line so that all
;; the variables are reset correctly. Otherwise do stuff for GNU/Linux.
(if (eq system-type 'darwin)
    (load "~/.emacs.d/aquamacs.el")
  (setq-default ispell-program-name "aspell"))
(put 'narrow-to-region 'disabled nil)

;; custom-set-variables; this part is automatically generated.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet smex smartparens nimrod-mode markdown-mode magit ipython highlight-parentheses haskell-mode goto-last-change evil d-mode company-irony cmake-font-lock auto-complete auctex)))
 '(safe-local-variable-values
   (quote
    ((eval add-hook
           (quote before-save-hook)
           (quote time-stamp))
     (projectile-project-compilation-cmd . "make -kwj8")
     (projectile-project-compilation-dir . "../ibamr-objs-dbg")
     (encoding . utf-8)
     (company-clang-arguments "-I/home/drwells/Applications/dealii-dev/include/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(match ((t (:background "midnight blue"))))
 '(mode-line ((t (:background "dim gray" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(term-color-blue ((t (:foreground "DodgerBlue1")))))
