;; Use the new Package manager.
(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)


(add-to-list 'load-path "~/Devel/usefulbits/emacs/")
(load "stieg.init.el")
