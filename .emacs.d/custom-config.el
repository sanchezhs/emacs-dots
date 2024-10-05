;; Custom Config
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Use package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)  ;; Instalar automáticamente los paquetes que falten


; Desactiva la pantalla de bienvenida
(setq inhibit-startup-message t)

;; Muestra los números de línea en los buffers
(global-display-line-numbers-mode t)

;; Modo oscuro
(load-theme 'doom-tokyo-night t)

;; Habilitar paréntesis coincidentes
(show-paren-mode 1)

;; Habilita el borrado de selección por defecto
(delete-selection-mode 1)

;; Hacer que Emacs use espacios en lugar de tabuladores
(setq-default indent-tabs-mode nil)

;; Establece el número de espacios para indentación
(setq-default tab-width 4)

;; Habilita el autocompletado de comandos
(ido-mode t)

;; Habilitar el modo de resaltado de sintaxis
(global-font-lock-mode t)


;; Establece un backup automático para no sobrescribir archivos originales
(setq backup-directory-alist `(("." . "~/.emacs-saves")))
(setq backup-by-copying t)

;; Habilita la función de copiar y pegar con el portapapeles del sistema
(setq select-enable-clipboard t)
(setq select-enable-primary t)

;; Habilita el resaltado de la línea actual
(global-hl-line-mode +1)

;; Configura el tamaño de la ventana de Emacs al abrir
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 100))

;; Quitar barras superiores
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Habilitar elpy
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :hook (python-mode . elpy-mode)
  :config
  (setq elpy-rpc-python-command "/home/samuel/Documentos/tws-workspace/monorepo/services/test/venv/bin/python3")
  (setq elpy-rpc-virtualenv-path 'current)
  (pyvenv-activate "/home/samuel/Documentos/tws-workspace/monorepo/services/test/venv/")
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;(when (require 'flycheck nil t)
;  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Activar python-mode automáticamente para archivos .py
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'company-backends 'company-jedi)

(pyvenv-mode 1)
;(setq elpy-rpc-virtualenv-path 'current)

;(setq elpy-rpc-python-command "/home/samuel/Documentos/tws-workspace/monorepo/services/test/venv/bin/python3")
;(pyvenv-activate "/home/samuel/Documentos/tws-workspace/monorepo/services/test/venv/")

;; Configurar Python para usar tabuladores en lugar de espacios
(setq python-indent-guess-indent-offset nil)  ;; Desactivar la adivinación de la indentación
(setq-default indent-tabs-mode t)             ;; Usar tabuladores en lugar de espacios
(setq-default tab-width 4)                    ;; Establecer el tamaño del tabulador en 4 espacios
(setq python-indent-offset 4)                 ;; Establecer el nivel de indentación de Python en 4 espacios

(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)   ;; Usar tabuladores en Python
            (setq python-indent 4)      ;; Tamaño de la indentación en Python
            (setq tab-width 4)))        ;; Ancho del tabulador


;; Habilitar whitespace-mode globalmente
(global-whitespace-mode 1)

;; Configurar cómo se muestran los espacios, tabuladores y finales de línea
(setq whitespace-style '(face tabs spaces trailing space-mark tab-mark))

;; Definir los caracteres visuales para espacios y tabuladores
(setq whitespace-display-mappings
      '(
        (space-mark 32 [183] [46]) ; Espacio como un punto medio (·)
        (tab-mark 9 [9655 9] [92 9]) ; Tabulador como una flecha (→)
       ))

;; Definir colores personalizados para los espacios y tabuladores
(custom-set-faces
 '(whitespace-space ((t (:foreground "gray20"))))  ;; Espacios en gris claro
 '(whitespace-tab ((t (:foreground "gray20"))))    ;; Tabuladores en gris claro
 '(whitespace-trailing ((t (:background "red" :foreground "yellow" :weight bold)))))  ;; Espacios finales en rojo

;; Mostrar los espacios y tabuladores solo en modos de programación
(add-hook 'prog-mode-hook 'whitespace-mode)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(setq doom-modeline-vcs-max-length 40)

;; Dashboard
(use-package dashboard
  :ensure t)
(dashboard-setup-startup-hook)

;; Usa iconos de `all-the-icons`
(setq dashboard-icon-type 'all-the-icons)

;; Configurar el Dashboard para mostrar los proyectos recientes de Projectile
(setq dashboard-items '((recents  . 5)        ;; Muestra los archivos recientes
                        (projects . 5)))      ;; Muestra los proyectos recientes de Projectile

;; Mostrar un banner (opcional)
(setq dashboard-startup-banner 'logo)  ;; Puedes cambiarlo a 'official o a un número para un banner personalizado

;; Activa Projectile para que funcione bien con Dashboard
(setq dashboard-projects-switch-function 'projectile-switch-project)


;; Fonts
(set-face-attribute 'default nil
                    :family "FiraCode Nerd Font Mono"  ;; Cambia "Fira Code" por el nombre de la fuente que prefieras
                    :height 100)         ;; El tamaño de la fuente (120 = 12pt)

;; Shift + arrows para moverse entre ventanas
(windmove-default-keybindings)

;; ;; Projectile
;; (require 'projectile)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (projectile-mode +1)
;; (setq projectile-generic-command "rg --files --hidden")
;; (setq projectile-grep-command "rg -n --no-heading --color=never -g '!vendor' -g '!node_modules' -g '!*.min.js' --hidden -e ")

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  ;:bind-keymap
  ;("C-c p" . projectile-command-map)
  :config
  (setq projectile-generic-command "rg --files --hidden"
        projectile-grep-command "rg -n --no-heading --color=never -g '!vendor' -g '!node_modules' -g '!*.min.js' --hidden -e ")
)


; Ibuffer
;; Groups
(setq ibuffer-saved-filter-groups
      '(("default"
         ("Python" (mode . python-mode))
         ("Emacs Config" (or
                          (filename . ".emacs")
                          (filename . "init.el")))
         ("Org" (mode . org-mode))
         ("Dired" (mode . dired-mode))
         ("Programming" (or
                         (mode . c-mode)
                         (mode . c++-mode)
                         (mode . java-mode)
                         (mode . js-mode)
                         (mode . html-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Formato
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 18 18 :left :elide)  ;; Nombre del buffer (18 caracteres)
              " "
              (size 9 -1 :right)        ;; Tamaño del buffer
              " "
              (mode 16 16 :left :elide) ;; Modo del buffer
              " "
              filename-and-process)))   ;; Ruta completa del archivo


(global-set-key (kbd "C-x C-b") 'ibuffer)  ;; Reemplaza el comando tradicional de `list-buffers` por `ibuffer`

; Dired + projectile
(global-set-key (kbd "C-c p d") 'projectile-dired)

; Padding
(use-package spacious-padding
  :ensure t)

(setq spacious-padding-widths
      '( :internal-border-width 0
         :header-line-width 4
         :mode-line-width 4
         :tab-width 4
         :right-divider-width 30
         :scroll-bar-width 8
         :fringe-width 8))

(setq spacious-padding-subtle-mode-line
      `( :mode-line-active 'default
         :mode-line-inactive vertical-border))


(spacious-padding-mode 1)


(set-face-attribute 'minibuffer-prompt nil
                    :foreground "cyan"    ;; Color del texto del prompt
                    :background "black"   ;; Fondo de la minibuffer
                    :weight 'bold)        ;; Texto en negrita


(use-package lsp-mode
  :ensure t
  :hook ((python-mode . lsp)         ;; Activar lsp en Python
         (java-mode . lsp)           ;; Activar lsp en Java
         (js-mode . lsp))            ;; Activar lsp en JavaScript
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable t)   ;; Mostrar información en la barra lateral
  (setq lsp-ui-doc-enable t)        ;; Mostrar documentación emergente
  (setq lsp-ui-imenu-enable t)      ;; Habilitar un menú de navegación
  (setq lsp-ui-peek-enable t))      ;; Habilitar la búsqueda visual de definiciones

;; Helm
(use-package helm
  :ensure t
  :init
  (helm-mode 1)
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-mini))
  :config
  (setq helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t))

;; Ajustes visuales
(setq helm-M-x-fuzzy-match t)       ;; Activar coincidencia difusa para M-x
(setq helm-buffers-fuzzy-matching t) ;; Activar coincidencia difusa para buffers
(setq helm-recentf-fuzzy-match t)    ;; Activar coincidencia difusa para archivos recientes

(defun vterm-split-right ()
  "Divide la ventana actual verticalmente y abre vterm en la nueva ventana."
  (interactive)
  (split-window-right)  ;; Divide la ventana verticalmente
  (other-window 1)      ;; Mueve el cursor a la nueva ventana
  (vterm))              ;; Abre vterm

(global-set-key (kbd "C-c v v") 'vterm-split-right)  ;; Asigna el atajo "C-c v v"

(defun vterm-split-below ()
  "Divide la ventana actual horizontalmente y abre vterm en la nueva ventana."
  (interactive)
  (split-window-below)  ;; Divide la ventana horizontalmente
  (other-window 1)      ;; Mueve el cursor a la nueva ventana
  (vterm))              ;; Abre vterm

(global-set-key (kbd "C-c v h") 'vterm-split-below)  ;; Asigna el atajo "C-c v h"
(global-set-key (kbd "M-i") 'imenu)

(use-package vterm
  :ensure t
  :bind (("C-c v v" . vterm-split-right)
         ("C-c v h" . vterm-split-below))
  :commands vterm)


; Move text
(move-text-default-bindings)

; Re indent text when moving text
(defun indent-region-advice (&rest ignored)
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
        (indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))

(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)

; Undo Fu
(use-package undo-fu
  :ensure t
  :bind (("C-z" . undo-fu-only-undo)
         ("C-S-z" . undo-fu-only-redo)))

; Smex
(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))


;; Dired
(use-package dired
  :ensure nil
  :bind ("C-c p d" . projectile-dired)
  :config
  (setq dired-listing-switches "-lah --group-directories-first"))

(define-key dired-mode-map (kbd "* .") 'dired-mark-files-regexp)

(use-package diredfl
  :ensure t
  :config
  (diredfl-global-mode 1))

; Volver a posición anterior del cursor
(global-set-key (kbd "C-o") 'pop-global-mark)

