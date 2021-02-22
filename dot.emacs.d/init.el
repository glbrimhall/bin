;; From https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/

(setq gc-cons-threshold 100000000)
(let ((file-name-handler-alist nil)) "~/.emacs.d/init-misc.el")

(let ((file-name-handler-alist nil)) "~/.emacs.d/init-global-keys.el")
(let ((file-name-handler-alist nil)) "~/.emacs.d/hook-c-mode.el")
(let ((file-name-handler-alist nil)) "~/.emacs.d/hook-java-mode.el")
(let ((file-name-handler-alist nil)) "~/.emacs.d/hook-perl-mode.el")
(let ((file-name-handler-alist nil)) "~/.emacs.d/hook-webxml-mode.el")
(let ((file-name-handler-alist nil)) "~/.emacs.d/hook-misc-mode.el")

;; Begin Melpa Package manager:
;(when (require 'package nil 'noerror)
;(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
;                    (not (gnutls-available-p))))
;       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
;  (add-to-list 'package-archives (cons "melpa" url) t))
;(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
;    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"));)
;(package-initialize)

;(add-to-list 'package-archives 
;             '("marmalade" . "http://marmalade-repo.org/packages/"))
;(add-to-list 'package-archives 
;             '("org" . "http://orgmode.org/elpa/") t)
;)

;; END Melpa Package manager :
;; BEGIN emacs-goodies
;;;(add-to-list 'load-path "~/.emacs.d/elpa")
;; END emacs-goodies

(if (locate-library "package")
    (progn
      (require 'package)
      (add-to-list 'package-archives
                   '("gnu" . "https://elpa.gnu.org/packages/"))
      (add-to-list 'package-archives
                   '("melpa-stable" . "https://stable.melpa.org/packages/"))
      (add-to-list 'package-archives
                   '("melpa" . "https://melpa.org/packages/"))
      (add-to-list 'package-archives
                   '("marmalade" . "https://marmalade-repo.org/packages/"))
      (package-initialize)
      (unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))
      (require 'use-package))
  (message "WARNING: Ancient emacs! No advice-add, package.el")
  (defmacro advice-add (&rest body))
  (defmacro use-package (&rest body))
  )

(add-to-list 'load-path "~/.emacs.d/goodies")

(use-package f
  :ensure t
  :commands (f-expand)
  )

(use-package control-lock
  :config
  (control-lock-global-keys)
  )

(load "~/.emacs.d/init-misc.el")
(load "~/.emacs.d/init-global-keys.el")

;; DO NOT move this lower - a number of auto-mode-alist values are set
;; custom over-rides need to happen after this.
(use-package generic-x
  :load-path "~/.emacs.d/goodies"
  :init (setq generic-define-unix-modes t)
)

;(autoload 'c-mode-hook    "~/.emacs.d/hook-c-mode.el"    "autoload c-mode")
;(autoload 'java-mode-hook "~/.emacs.d/hook-java-mode.el" "autoload java-mode")
;(autoload 'perl-mode-hook "~/.emacs.d/hook-perl-mode.el" "autoload perl-mode")
;(autoload 'docker-mode-hook "~/.emacs.d/hook-docker-mode.el" "autoload docker-mode")
;(autoload 'package-menu-mode-hook "~/.emacs.d/hook-package-mode.el" "autoload package-mode")

(autoload 'web-init  "~/.emacs.d/mode-web.el" "web-mode")
;(add-hook 'web-mode-hook 'my-web-hook)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.htm?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\.x??$" . web-mode)                     )
(add-to-list 'auto-mode-alist '("\\.dtd\\'" . web-mode)                     )
;(add-to-list 'auto-mode-alist '("\.x??$" . nxml-mode)                   )
;(add-to-list 'auto-mode-alist '("\.dtd$" . nxml-mode)                   )
(add-to-list 'auto-mode-alist '("\\.[mM][aA][kK]\\'" . makefile-mode)       )
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode)                   )
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)                      )
(add-to-list 'auto-mode-alist '("\\.[tT]\\'" . makefile-mode)               )
(add-to-list 'auto-mode-alist '("\\.emacs\\'" . lisp-mode)                  )
(add-to-list 'auto-mode-alist '("\\.el\\'" . lisp-mode)                     )
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)       )
(add-to-list 'auto-mode-alist '("\\.conf\\'" . generic-mode)                )
(add-to-list 'auto-mode-alist '("\\.cfg\\'" . generic-mode)                )
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)                 )
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . perl-mode)  )

(use-package web-mode
  :ensure t
  :mode (("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.xml\\'" . web-mode)
         ("\\.xsl?\\'" . web-mode)
         ("\\.xslt\\'" . web-mode)
         ("\\.html?\\'" . web-mode))
  :bind (("M-0" . web-mode-fold-or-unfold)
         ("M-9" . auto-complete))
  ;:init (web-init)
  :config (progn
        (setq web-mode-markup-indent-offset 2
           web-mode-css-indent-offset 2
           web-mode-code-indent-offset 2
           web-mode-markup-indent-offset 2
           web-mode-enable-comment-keywords t
           web-mode-enable-block-face t
           web-mode-enable-auto-pairing t
           web-mode-enable-css-colorization t
           web-mode-enable-block-face t
           web-mode-enable-current-element-highlight t
           web-mode-ac-sources-alist
              '(("php" . (ac-source-yasnippet ac-source-php-auto-yasnippets))
                ("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
                ("css" . (ac-source-css-property ac-source-emmet-css-snippets)))
           ))
)

(use-package php-mode
  :ensure t
  :mode (("\\.php\\'" . php-mode))
)

;; Code-completion for js2-mode
(use-package tern
   :ensure t
   :config
     (use-package company-tern
        :ensure t
        :init (add-to-list 'company-backends 'company-tern))
)

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
;;  :bind (:map tern-mode-keymap
;;              ("M-." . nil)
;;              ("M-," . nil))
  :init (setq js-basic-indent 2)
  (add-hook 'js2-mode-hook (lambda ()
                             (tern-mode t)
                             (company-mode t)
                             ;;(js2-imenu-extras-mode t)
                             ))
)

;; https://github.com/waymondo/hemacs/blob/master/init.el
(use-package sh-script
  :mode (("\\.*bashrc$" . sh-mode)
         ("\\.*bash_profile" . sh-mode)
         ("\\.sh\\'" . sh-mode))
  :config
  (progn
  (setq-default sh-indentation 2
                sh-basic-offset 2)
  )
)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :bind (("M-0" . markdown-preview))
  :init (setq markdown-command "markdown")
)

(use-package dockerfile-mode
  :ensure t
)

(use-package yaml-mode
  :load-path "~/.emacs.d/goodies"
  :bind (("C-m" . newline-and-indent))
  :mode (("\\.yml\\'" . yaml-mode))
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (js2-mode counsel imenu-anywhere swiper ivy yasnippet web-mode use-package php-mode markdown-mode f dockerfile-mode auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
