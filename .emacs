;;(load "~/.emacs.d/custom-config.el")

(setq package-enable-at-startup nil)

;; Carga los paquetes necesarios para manejar Org Babel
(require 'org)
(require 'ob-tangle)

;; Tangle y carga el archivo init.org
(org-babel-load-file (expand-file-name "~/.emacs.d/README.org"))


(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
 (load custom-file))


