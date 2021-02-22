;; BEGIN hook-mode-misc.el
;; BEGIN package-mode-hook

(defun my-package-mode-hook ()
  (setq tabulated-list-format
        (vconcat (mapcar (lambda (arg) (list (nth 0 arg) (nth 1 arg)
                                       (or (nth 2 arg) t)))
                         tabulated-list-format)))
  
)

(add-hook 'package-menu-mode-hook 'my-package-mode-hook)

;; END package-mode-hook
;; BEGIN dockerfile modes

(require 'dockerfile-mode)

;; END dockerfile modes
;; BEGIN generic-x modes

(setq generic-define-unix-modes t)
(require 'generic-x)

;; end generic-x modes
;; END hook-mode-misc.el
;; BEGIN yaml modes

(require 'yaml-mode)

(defun my-yaml-mode-hook ()
   (define-key yaml-mode-map "\C-m" 'newline-and-indent)
)

(add-hook 'yaml-mode-hook 'my-yaml-mode-hook)

;; END yaml modes
