;;
;; Sets the directory location of this file to a variable for later relative load use.
;;
(defconst emacsd-directory (file-name-directory (or load-file-name buffer-file-name)))

;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(package-selected-packages
   '(company-irony flycheck-irony irony markdown-mode xclip js2-refactor js2-mode yaml-mode flycheck-rust rust-mode rustic cargo yasnippet-snippets yasnippet tide web-mode use-package javascript-mode flycheck company))
 '(safe-local-variable-values '((setq tab-width 4) (indent-tabs-mode nil) (tab-width 4)))
 '(select-enable-clipboard t)
 '(standard-indent 2)
 '(typescript-indent-level 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;
;; My Global settings
;;
(setq-default column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default line-number-mode t)
(setq-default tab-stop-list '(3 6 9 12 15))
(setq-default tab-width 3)

;; Emacs Backup file settings
;; From https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq-default backup-directory-alist `(("." . "~/.emacs_backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;
;; Global key bindings..
;;
(global-set-key (kbd "C-z") 'term)
(global-set-key (kbd "M-s c") 'compile)
(global-set-key (kbd "M-s d") 'delete-trailing-whitespace)
(global-set-key (kbd "M-s g") 'find-grep)
(global-set-key (kbd "M-s k") 'kill-some-buffers)
(global-set-key (kbd "M-s r") 'rgrep)
(global-set-key (kbd "M-s s") 'sort-lines)

;; Add Melpa to the list of places we get our packages from.
(require 'package)
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/") t)

;; Enable Paren highlighting
(show-paren-mode t)
(setq-default blink-matching-paren t)

;; JSON Settings
(defun stieg-json-settings () "Sets up stieg JSON settings"
  (make-local-variable 'js-indent-level)
  (setq js-indent-level 2))
(add-hook 'json-mode-hook 'stieg-json-settings)

;; Javascript Settings
(defun setup-js-mode () "Set's up the Javascript major mode"
  (interactive)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (company-mode +1)
  (yas-minor-mode)
  )
(add-hook 'js-mode-hook #'setup-js-mode)


;; Typescript Settings
(defun setup-tide-mode () "Set's up TIDE major mode"
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (yas-minor-mode)
  ;; (set (make-local-variable 'company-backends)
  ;;      '((company-tide company-yasnippet)))
  )
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Typescript TSX Settings
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;;(add-hook 'after-init-hook (lambda () (flycheck-add-mode 'typescript-tslint 'web-mode)))

;; Enables flycheck for all buffers in Emacs
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Clear out whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Fix the annoying yes-or-no to be y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Add my snippets to the yasnippet path
;;(add-to-list 'load-path (expand-file-name "./snippets" (file-name-directory load-file-name)))
(add-hook
 'after-init-hook
 (lambda ()
   (require 'yasnippet)
   (add-to-list
    `yas-snippet-dirs
    (expand-file-name "snippets" emacsd-directory)
    )
   (yas-reload-all)
   )
 )

;; C/C++ Settings
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; (defun stieg-c-settings () "Sets up stieg's C settings"
;;   (setq c-basic-offset 3)
;;   (setq indent-tabs-mode nil)
;;   (setq-default tab-stop-list '(3 6 9 12 15))
;;   )

;; (defun racecapture-c-settings ()
;;   (setq c-basic-offset 4)
;;   (setq indent-tabs-mode nil)
;;   (setq-default tab-stop-list '(4 8 12 16 20))
;;   )
;; (add-hook 'c-mode-hook 'stieg-c-settings)


;; Makefile Settings
;; (defun stieg-makefile-settings ()
;;   (setq-default tab-width 8)
;;   (setq-default tab-stop-list '(8 16 24 32 40)))
;; (add-hook 'makefile-mode-hook 'stieg-makefile-settings)

;;(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
