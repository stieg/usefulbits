;; Stieg init.el settings

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/Devel/stieg/usefulbits/emacs")
(load "stieg.init.el") ;; Load up the init.el in the git file.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#222222" "#a85454" "#65a854" "#8d995c" "#5476a8" "#9754a8" "#54a8a8" "#969696"])
 '(custom-safe-themes
   (quote
    ("2dcf008990e8bb027e2227e05a9f4a01d5e71a23c15a757b455b8cc29759a558" "6c7db7fdf356cf6bde4236248b17b129624d397a8e662cf1264e41dab87a4a9a" "3922d601351cf1b3d8c1e0fb60c5e3b0c473126503a0bb19cf21e753410ead51" default)))
 '(fci-rule-color "#3f1a1a")
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules" "dist")))
 '(inhibit-startup-screen t)
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (yasnippet-snippets tide tss json-mode rust-mode rust-playground yaml-mode company js2-highlight-vars js2-mode yoshi-theme el-get yasnippet puppet-mode go-mode flymake-puppet)))
 '(rainbow-delimiters-max-face-count 10)
 '(standard-indent 2)
 '(typescript-indent-level 2)
 '(window-divider-default-right-width 1)
 '(window-divider-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
