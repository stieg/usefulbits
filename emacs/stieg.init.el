(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
;;
;; Plugins
;;
;;;;
;;;; Yasnippet
;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")
(setq yas/root-directory '("~/emacs.d/plugins/yasnippet-0.6.1c/snippets"))

;;;;
;;;; Git
;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/git")
(require 'git) ;; our git control system.
(require 'git-blame) ;; our git control system.

;;;;
;;;; ERC (IRC for emacs)
;;;;
(require 'erc) ; ERC is included with emacs starting 22.3
; freenode
(global-set-key (kbd "M-s e f") (lambda () (interactive)
                                (erc :server "irc.freenode.net"
                                     :port "6667"
                                     :nick "stieg"
                                     :full-name "Andrew Stiegmann (andrew.stiegmann [at] gmail [dot] com")))
(setq erc-autojoin-channels-alist "freenode.net #perfkit")
; /freenode

(setq erc-interpret-mirc-color t)


;; Clear out whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Custom settings
(defun my-c-settings ()
  (setq c-basic-offset 3)
  (setq indent-tabs-mode nil))

(defun my-perl-settings ()
  (setq perl-indent-level 3))

;; Set the standards for Makefiles
(defun my-makefile-settings ()
  (setq-default tab-width 8)
  (setq-default tab-stop-list '(8 16 24 32 40)))

(add-hook 'c-mode-hook 'my-c-settings)
(add-hook 'perl-mode-hook 'my-perl-settings)
(add-hook 'makefile-mode-hook 'my-makefile-settings)

;;
;; Special key bindings..
;;
(global-set-key (kbd "C-z") 'term)
(global-set-key (kbd "M-s k") 'kill-some-buffers)
(global-set-key (kbd "M-s c") 'compile)
(global-set-key (kbd "M-s g") 'find-grep)

;; Fix the annoying yes-or-no to be y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; My Global settings
(setq-default tab-stop-list '(3 6 9 12 15))
(setq-default tab-width 3)
(setq-default indent-tabs-mode nil)
(setq-default line-number-mode t)
(setq-default column-number-mode t)

;;;; Enable Paren highlighting
(show-paren-mode t)
(setq-default blink-matching-paren t)

;; Fonts
;; ============
;;
;;;; The next command sets the fontsize.  Size is 1/10 of value.
;;(set-face-attribute 'default nil :height 70)

(setq font-lock-maximum-decoration t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
(add-hook 'cc-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c++-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'turn-on-font-lock)
(add-hook 'sh-mode-hook 'turn-on-font-lock)
(add-hook 'shell-script-mode-hook 'turn-on-font-lock)
(add-hook 'makefile-mode-hook 'turn-on-font-lock)
(add-hook 'perl-mode-hook 'turn-on-font-lock)
(add-hook 'xrdb-mode-hook 'turn-on-font-lock)

;; Mode Options
;; ============

(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode"   t)
(autoload 'objc-mode "cc-mode" "Objective C Editing Mode" t)
(autoload 'text-mode "indented-text-mode" "Indented Text Editing Mode" t)
(autoload 'xrdb-mode "xrdb-mode" "Mode for editing X resource files" t)
(autoload 'ps-mode "ps-mode" "Major mode for editing PostScript" t)
(setq auto-mode-alist
      (append '(
      ("\\.C$"              . c++-mode)
      ("\\.cc$"             . c++-mode)
      ("\\.c$"              . c-mode)
      ("\\.h$"              . c++-mode)
      ("\\.i$"              . c++-mode)
      ("\\.ii$"             . c++-mode)
      ("\\.m$"              . objc-mode)
      ("\\.pl$"             . perl-mode)
      ("\\.sql$"            . c-mode)
      ("\\.(ba)?sh$"        . shell-script-mode)
      ("\\.spec$"           . shell-script-mode)
      ("\\.mak.?$"          . makefile-mode)
      ("\\.make$"           . makefile-mode)
      ("\\.mk$"             . makefile-mode)
      ("\\.GNU$"            . makefile-mode)
      ("makefile$"          . makefile-mode)
      ("Imakefile$"         . makefile-mode)
      ("\\.Xdefaults$"      . xrdb-mode)
      ("\\.Xenvironment$"   . xrdb-mode)
      ("\\.Xresources$"     . xrdb-mode)
      ("*.\\.ad$"           . xrdb-mode)
      ("\\.[eE]?[pP][sS]$"  . ps-mode)
      ) auto-mode-alist))
