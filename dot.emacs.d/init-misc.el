;; BEGIN init-misc

;(setq color-themes '())
(use-package color-theme
  :config
    (color-theme-initialize)
    (setq color-theme-is-global t)
    (customize-set-variable 'frame-background-mode 'dark)
    (color-theme-lethe)
)

;;(use-package molokai-theme
;;  :ensure t
;;  :load-path "themes"
;;  :init
;;  (setq molokai-theme-kit t)
;;  :config
;;  (load-theme 'molokai t)
;;)

;;END color-theme

;;(use-package auto-complete-config
;;  :ensure auto-complete
;;  :commands auto-complete-mode   
;;  :config
;;    (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;    (ac-config-default)
;;)

(use-package company
  :ensure t
)

(use-package ivy
  :ensure ivy
  :bind (:map ivy-minibuffer-map
              ("TAB" . ivy-next-line)
              ([backtab] . ivy-previous-line))
  :config
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (bind-key "C-c C-r" 'ivy-resume)
)

(use-package swiper
  :ensure swiper
  :bind
  ("C-s" . swiper)
)

(use-package imenu-anywhere
  :ensure imenu-anywhere
  :bind
  ("C-." . ivy-imenu-anywhere)
)

;;(use-package projectile
;;  :ensure f
;;  :config
;;  (projectile-global-mode)
;;  (setq projectile-mode-line
;;        '(:eval (format " [%s]" (projectile-project-name))))
;;  (setq projectile-project-searh-path '("~/projects/" "~/github"))
;;  (setq projectile-remember-window-configs t)
;;  (setq projectile-completion-system 'ivy)
;;)

(use-package counsel
  :ensure t
  :bind
  ("C-x C-f" . counsel-find-file)
  ("C-c C-h" . counsel-M-x)
  ("C-c C-f" . counsel-describe-function)
  ("C-c C-v" . counsel-describe-variable)
  ("C-c C-l" . counsel-find-library)
  ("C-c C-i" . counsel-info-lookup-symbol)
  ("C-c C-u" . counsel-unicode-char)
  ("C-c C-k" . counsel-ag)
)

;;(use-package yasnippet
;;  :ensure t
;;  :init
;;  (progn
;;    (add-hook 'after-save-hook
;;              (lambda ()
;;                (when (eql major-mode 'snippet-mode)
;;                  (yas-reload-all))))
;;    (setq yas-indent-line 'fixed)
;;    (yas-global-mode 1))
;;  :mode ("\\.yasnippet" . snippet-mode)
;;  )

;; BEGIN CUSTOMIZATION
;; last lines should end in a carriage return
(setq require-final-newline t)

;; display date and time always
(setq display-time-day-and-date t)
(display-time)

;; highlight matching parentheses next to cursor
(use-package paren
  :config
  (show-paren-mode t)
)

;; don't ask annoying question to open softlink to git controlled file
(setq vc-follow-symlinks nil)

;; type "y"/"n" instead of "yes"/"no"
(fset 'yes-or-no-p 'y-or-n-p)

;; do not add new lines with arrow down at end of buffer
(setq next-line-add-newlines nil)

;; C-k kills whole line and newline if at beginning of line
(setq kill-whole-line t)

(setq c-basic-offset 3)
;;(setq c-default-style '"stroustrup")
;;(setq c-default-style '"k&r")
;;(setq c-default-style '"ellemtel")
(setq c-default-style '"gnu")

;;(c-set-offset 'substatement-open 3)
;;(c-set-offset 'member-init-intro 0)
;;(c-set-offset 'substatement-open 3)
(c-set-offset 'statement-block-intro 0)

;; in C mode, delete hungrily
(setq c-hungry-delete-key t)
;;(setq c-tab-always-indent t)

;; spaces instead of tabs by default
;; when tabs allowed, tabs shown in 2 spaces
(setq-default tab-width 2
              standard-indent 2
              indent-tabs-mode nil)
;(setq tab-stop-list '(1 4 7 10 13 16 19 ...))

; DOESN'T SEEM TO WORK: let emacs put in a return for you after left curly braces,
; right curly braces, and semi-colons.
;(setq c-auto-newline 1)

;; position cursor to end of output in shell mode
(setq auto-show-make-point-visible t)

;; show column number
(column-number-mode 1)

; highlight region between point and mark
(transient-mark-mode t)
; highlight during query
(setq query-replace-highlight t)        
; highlight incremental search
(setq search-highlight t)

;; make text-mode default
(setq default-major-mode 'text-mode)

;(set-language-environment 'german)
(set-terminal-coding-system             'iso-latin-1)
;(set-terminal-coding-system             'iso-8559-5)
;(prefer-coding-system                   __'XXX)
;(setq default-buffer-file-coding-system 'XXX)

;; we want fontification in all modes
(global-font-lock-mode t)
;; maximum possible fontification
(setq font-lock-maximum-decoration t)

;; disable backup and auto-save
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq auto-save-default nil)

;;(autoload 'perl-mode "cperl-mode"
;;  "alternate mode for editing Perl programs" t)
;;(setq cperl-hairy t)

(defun kill-rectangle-position () 
(interactive) 
(exchange-point-and-mark) 
(point-to-register 'A) 
(exchange-point-and-mark) 
(if (> (point) (mark)) 
(kill-rectangle (mark) (point)) 
(kill-rectangle (point) (mark))) 
(jump-to-register 'A) 
) 

(defun yank-rectangle-position () 
(interactive) 
(point-to-register 'A) 
(yank-rectangle) 
(jump-to-register 'A) 
) 

(defun scroll-up-windows () 
(interactive) 
(scroll-up)
;(scroll-other-window)
(other-window 1)
(scroll-up)
(other-window 1)
) 

(defun scroll-down-windows () 
(interactive) 
(scroll-down)
;(scroll-other-window-down)
(other-window 1)
(scroll-down)
(other-window 1)
) 

(defun next-line-windows () 
(interactive) 
(scroll-up 1)
;(scroll-other-window)
;(other-window 1)
(scroll-other-window 1)
;(other-window 1)
) 

(defun previous-line-windows () 
(interactive) 
(scroll-down 1)
;(scroll-other-window-down)
(scroll-other-window-down 1)
) 

(setq compile-command "make -j4 ")

(put 'upcase-region 'disabled nil)

(defun get-my-tab-length () 3) 

; build a list from 1 to n 
(defun iota 
  (n) 
  (if (= n 0) '() 
    (append (iota (- n 1)) (list n)))) 

;build the tab list 
(defun create-tab-list 
  (length) 
  (mapcar (lambda (n) (* (get-my-tab-length) n)) (iota length))) 

; display tabs with a . prefix
(standard-display-ascii ?\t ".\t") 

; set google chrome as the default browser
;;(setq browse-url-browser-function 'browse-url-firefox)
(setq browse-url-browser-function 'browse-url-chromium)

; enable search competion with TAB
;(require 'icicles)

; Disable asking to save when exit:
; From https://stackoverflow.com/questions/6762686/prevent-emacs-from-asking-modified-buffers-exist-exit-anyway

(defadvice save-buffers-kill-emacs (around no-y-or-n activate)
  (cl-flet ((yes-or-no-p (&rest args) t)
         (y-or-n-p (&rest args) t))
    ad-do-it))



;; END init-misc
