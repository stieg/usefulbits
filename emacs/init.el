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

;; Plugins
(add-to-list 'load-path "~/.emacs.d/myemacs/plugins/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/myemacs/plugins/yasnippet-0.6.1c/snippets")


;; Clear out whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Custom settings
(defun my-c-settings ()
  (setq c-basic-offset 3)
  (setq indent-tabs-mode nil))

(defun my-perl-settings ()
  (setq perl-indent-level 3))

(add-hook 'c-mode-hook 'my-c-settings)
(add-hook 'perl-mode-hook 'my-perl-settings)

;;
;; Special key bindings..
;;
(global-set-key (kbd "C-z") 'shell)
(global-set-key (kbd "M-s k") 'kill-some-buffers)

;; Fix the annoying yes-or-no to be y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable Paren highlighting
(setq show-paren-mode t)
(setq blink-matching-paren t)

;; My Global settings
(setq-default tab-stop-list '(3 6 9 12 15 18))
(setq-default tab-width 3)
(setq-default indent-tabs-mode nil)
;; Enable Paren highlighting
(setq show-paren-mode t)
(setq blink-matching-paren t)

;; Fonts
;; ============
;;
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
      (append '(("\\.C$"       . c++-mode)
		("\\.cc$"      . c++-mode)
		("\\.c$"       . c-mode)
		("\\.h$"       . c++-mode)
		("\\.i$"       . c++-mode)
		("\\.ii$"      . c++-mode)
		("\\.m$"       . objc-mode)
		("\\.pl$"      . perl-mode)
		("\\.sql$"     . c-mode)
		("\\.sh$"      . shell-script-mode)
		("\\.mak.?$"     . makefile-mode)
		("\\.GNU$"     . makefile-mode)
		("makefile$"   . makefile-mode)
		("Imakefile$"  . makefile-mode)
		("\\.Xdefaults$"    . xrdb-mode)
		("\\.Xenvironment$" . xrdb-mode)
		("\\.Xresources$"   . xrdb-mode)
		("*.\\.ad$"         . xrdb-mode)
		("\\.[eE]?[pP][sS]$" . ps-mode)
		) auto-mode-alist))

