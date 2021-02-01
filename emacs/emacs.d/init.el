;;; init.el --- Stieg configuration for emacs.

;; Sets the directory location of this file to a variable for later relative load use.
;;
(defconst emacsd-directory (file-name-directory (or load-file-name buffer-file-name)))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#222222" "#a85454" "#65a854" "#8d995c" "#5476a8" "#9754a8" "#54a8a8" "#969696"])
 '(custom-safe-themes
   '("2dcf008990e8bb027e2227e05a9f4a01d5e71a23c15a757b455b8cc29759a558" "6c7db7fdf356cf6bde4236248b17b129624d397a8e662cf1264e41dab87a4a9a" "3922d601351cf1b3d8c1e0fb60c5e3b0c473126503a0bb19cf21e753410ead51" default))
 '(fci-rule-color "#3f1a1a")
 '(grep-find-ignored-directories
   '("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules" "dist"))
 '(inhibit-startup-screen t)
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   '(clang-format+ clang-format simpleclip company-irony flycheck-irony irony markdown-mode xclip js2-refactor js2-mode yaml-mode flycheck-rust rust-mode rustic cargo yasnippet-snippets yasnippet tide web-mode use-package javascript-mode flycheck company))
 '(rainbow-delimiters-max-face-count 10)
 '(safe-local-variable-values
   '((c-set-style . "linux")
     (c-set-style . linux)
     (c-progress-interval . t)
     (setq tab-width 4)
     (indent-tabs-mode nil)
     (tab-width 4)))
 '(select-enable-clipboard nil)
 '(standard-indent 4)
 '(xclip-select-enable-clipboard t))

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
;;(setq-default indent-tabs-mode nil)
(setq-default line-number-mode t)

;; Emacs Backup file settings
;; From https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq-default backup-directory-alist `(("." . "~/.emacs_backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Global key bindings. Keep code agnostic
(global-set-key (kbd "C-z") 'term)
(global-set-key (kbd "M-s d") 'delete-trailing-whitespace)
(global-set-key (kbd "M-s g") 'find-grep)
(global-set-key (kbd "M-s k") 'kill-some-buffers)
(global-set-key (kbd "M-s o") 'revert-buffer)
(global-set-key (kbd "M-s r") 'rgrep)
(global-set-key (kbd "M-s s") 'sort-lines)

;; Clear out trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Fix the annoying yes-or-no to be y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Xclip
;; (require 'xclip)
;; (xclip-mode 1)

;; ;; Simpleclip settings
;; (require 'simpleclip)
;; (simpleclip-mode 1)
;; (global-set-key (kbd "M-s c") 'simpleclip-copy)
;; (global-set-key (kbd "M-s x") 'simpleclip-cut)
;; (global-set-key (kbd "M-s v") 'simpleclip-paste)

;; Add Melpa to the list of places we get our packages from.
(require 'package)
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/") t)

;; Enable Paren highlighting
(show-paren-mode t)
(setq-default blink-matching-paren t)

;; JSON Settings
(defun stieg-json-settings () "Set up stieg JSON settings."
  (make-local-variable 'js-indent-level)
  (setq js-indent-level 2))
(add-hook 'json-mode-hook 'stieg-json-settings)


;; Javascript Settings
(defun setup-js-mode ()
  "Set up the Javascript major mode."
  (interactive)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (company-mode +1)
  (yas-minor-mode)
  )
(add-hook 'js-mode-hook #'setup-js-mode)


;; Typescript Settings
(defun setup-tide-mode ()
  "Set up TIDE major mode."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (yas-minor-mode)
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

;; C Settings
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'irony-mode)

;; C++ Settings
(add-hook 'c++-mode-hook 'irony-mode)

;; Irony Settings
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Company Settings
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; Clang-format
(require 'clang-format)

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

; x-clip support for emacs-nox / emacs-nw
(defun my-copy-to-xclipboard(arg)
  "Copies selected text to X clipboard."
  (interactive "P")
  (cond
   ((not (use-region-p))
    (message "Nothing to yank to X-clipboard"))
   ((and (not (display-graphic-p))
         (/= 0 (shell-command-on-region
                (region-beginning) (region-end) "xsel -i -b")))
    (error "Is program `xsel' installed?"))
   (t
    (when (display-graphic-p)
      (call-interactively 'clipboard-kill-ring-save))
    (message "Yanked region to X-clipboard")
    (when arg
      (kill-region  (region-beginning) (region-end)))
    (deactivate-mark))))

(defun my-cut-to-xclipboard()
  "Yank text to X Clipboard."
  (interactive)
  (my-copy-to-xclipboard t))

(defun my-paste-from-xclipboard()
  "Uses shell command `xsel -o' to paste from x-clipboard. With
  one prefix arg, pastes from X-PRIMARY, and with two prefix args,
  pastes from X-SECONDARY."
        (interactive)
        (if (display-graphic-p)
            (clipboard-yank)
          (let*
              ((opt (prefix-numeric-value current-prefix-arg))
               (opt (cond
                     ((=  1 opt) "b")
                     ((=  4 opt) "p")
                     ((= 16 opt) "s"))))
            (insert (shell-command-to-string (concat "xsel -o -" opt))))))

(global-set-key (kbd "M-s x") 'my-cut-to-xclipboard)
(global-set-key (kbd "M-s c") 'my-copy-to-xclipboard)
(global-set-key (kbd "M-s v") 'my-paste-from-xclipboard)

(provide 'init)
;;; init.el ends here
