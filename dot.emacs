;;; Control-lock.el --- Like caps-lock, but for your control key.  Give your pinky a rest!

;; Copyright (C) 2008 Craig Muth

;; Author: Craig Muth
;; Maintainer: Craig Muth
;; Created 10 November 2007
;; Version 1.1.2
;; Version Keywords: control key lock caps-lock

;;;; Commentary
;; Quick Start / installation:
;; 1. Download this file and put it next to other files emacs includes
;; 2. Add this to you .emacs file and restart emacs:
;;      (require 'control-lock)
;;      (control-lock-keys)
;; 3. Type C-z and follow the following steps
;;
;; Use Case:
;;   - Type C-z
;;     - The cursor changes to a red underscore, so you know control-lock is on
;;   - Type n to go to the next line
;;   - Type v to scroll down
;;   - Type xf to open a file
;;   - Type any other chars, and emacs will behave as though control is held down
;;   - Type z to exit control-lock
;;     - The cursor changes back to a box, so you know control-lock is off
;;
;; Input from commands:
;;   When in control lock and a command gets input from the minibuffer, control-lock
;;   doesn't interfere (i.e. chars are temporarily not converted to control chars).
;;
;; Inserting literal char:
;;   Pressing ' will temporarily turn control-lock off for the following key stroke.
;;   This is useful, for example, for typing 's to sort in dired mode.
;;
;; Todo
;;   Are there problems when using emacs in the terminal?
;;     - Changing the cursor to an underscore might not work
;;

;;; Change Log:
;; 2007-11-24 - Initial release
;; 2008-01-03 - Use C-z to enable/disable (C-, doesn't work in terminals)
;; 2008-01-22 - Holding down shift acts to disable control-lock

(defun control-lock-letter (l ch)
  "Called when keys are pressed.  If we deem control-lock to be
enabled, it returns the control-version of the key.  Otherwise
it just returns the key."
  (if (control-lock-enabled-p)
    ch l))

(defun control-lock-enabled-p ()
  "Returns whether control lock should be enabled at a given point"
  (and control-lock-mode-p
    ; If not disable once (turning off if set)
    (if control-lock-disable-once
      (progn
        (setq control-lock-disable-once nil)
        nil  ; Not enabled this time
        )
      t  ; It's enabled as far as we know here
      )
    (not isearch-mode)
    (not (string-match "\\*Minibuf" (buffer-name)))))

; Make ctrl-lock be off by default
;(setq control-lock-mode-p nil)
; Make ctrl-lock be on by default
(setq control-lock-mode-p t)

(defun control-lock-quote (p)
  "Make ' disable ctrl-lock for next key"
  (if (control-lock-enabled-p)
    (progn
      (setq control-lock-disable-once t)
      "")
    "'"))
(setq control-lock-disable-once nil)
(define-key key-translation-map "'" 'control-lock-quote)

(defun control-lock-map-key (l ch fun)
  "Makes function to handle one key, and maps it to that key"
  (eval (read
    (concat
      "(progn"
        "(defun control-lock-" fun " (p) (control-lock-letter \"" l "\" (kbd \"" ch "\")))"
        "(define-key key-translation-map \"" l "\" 'control-lock-" fun "))"
      ")"
      ))))

; Map lowercase keys
(let ((c ?a) s)
  (while (<= c ?z)
    (setq s (char-to-string c))
    (control-lock-map-key s (concat "C-" s) s)
    (setq c (+ c 1))))

;;DISABLED: Map uppercase keys to lowercase
; Map uppercase keys to M-
(let ((c ?A) s)
  (while (<= c ?Z)
    (setq s (char-to-string c))
    (control-lock-map-key s (concat "M-" s) s)
;    (control-lock-map-key s (downcase s) s)
    (setq c (+ c 1))))

; Map numbers
(let ((c ?0) s)
  (while (<= c ?9)
    (setq s (char-to-string c))
    (control-lock-map-key s (concat "M-" s) s)
    (setq c (+ c 1))))

; Map misc keys
;(control-lock-map-key "," "C-," "comma")
;(control-lock-map-key "`" "C-`" "backtick")
;(control-lock-map-key "\\t" "C-<tab>" "tab")
;(control-lock-map-key "/" "C-/" "slash")
;(control-lock-map-key " " "C-@" "space")
;(control-lock-map-key "[" "C-[" "lsqrbracket")
;(control-lock-map-key "\\\\" "C-\\\\" "backslash")
;(control-lock-map-key ";" "C-;" "semicolon")
;(control-lock-map-key "." "C-." "period")
;(control-lock-map-key "=" "C-=" "equals")
;(control-lock-map-key "-" "C--" "dash")

(defun control-lock-global-keys ()
  "Sets default keys - C-z enables control lock."
  (global-unset-key (kbd "C-u"))
  (global-set-key (kbd "C-u") 'control-lock-enable)
;  (global-unset-key (kbd "M-u"))
;  (global-set-key (kbd "M-u") 'control-lock-enable)
)

(defun control-lock-local-keys ()
  "Sets default keys - C-z enables control lock."
  (local-unset-key (kbd "C-u"))
  (local-set-key (kbd "C-u") 'control-lock-enable)
;  (local-unset-key (kbd "M-u"))
;  (local-set-key (kbd "M-u") 'control-lock-enable)
)

(defun control-lock-enable () (interactive)
  "Enable control lock.  This function should be mapped to the key the
user uses to enable control-lock."
  (if control-lock-mode-p
    (progn
      (setq control-lock-mode-p nil)
      ; Set cursor color back to orig
      (set-face-background 'cursor control-lock-orig-cursor-color)
      (customize-set-variable 'cursor-type 'box))
    ; Else
    (progn
      (setq control-lock-mode-p t)
      ; Save orig color and set to orange
      (setq control-lock-orig-cursor-color (face-background 'cursor))
      (set-face-background 'cursor "#ff3300")
      (customize-set-variable 'cursor-type '(hbar . 3)))))

;(provide 'control-lock)

;; autocomplete

;(add-to-list 'load-path "~/.emacs.d/")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;(ac-config-default)

;; yasnippet ( for java autocomplete )
;(add-to-list 'load-path
;              "~/.emacs.d/plugins/yasnippet")
;(require 'yasnippet)
;(yas-global-mode 1)

;; color-theme
;(require 'color-theme)
;(color-theme-initialize)
;(setq color-theme-is-global t)
;(color-theme-high-contrast)
;(color-theme-hober)

;; BEGIN CUSTOMIZATION
;; last lines should end in a carriage return
(setq require-final-newline t)

;; display date and time always
(setq display-time-day-and-date t)
(display-time)

;; highlight matching parentheses next to cursor
(require 'paren)
(show-paren-mode t)

;; type "y"/"n" instead of "yes"/"no"
(fset 'yes-or-no-p 'y-or-n-p)

;; do not add new lines with arrow down at end of buffer
(setq next-line-add-newlines nil)

;; C-k kills whole line and newline if at beginning of line
(setq kill-whole-line t)

(require 'cc-mode)
(require 'perl-mode)
;;(require 'c-mode)
;;(require 'cperl-mode)

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
;; when tabs allowed, tabs shown in 3 spaces
(setq-default tab-width 3
              standard-indent 3
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

(control-lock-global-keys)

(setq compile-command "make -j4 ")
;(global-set-key [?\M-1] 'help-command) 
(global-set-key [?\M-3] 'find-file) 
(global-set-key [?\M-8] "\M-x shell") 
(global-set-key [?\M-9] 'gdb) 
(global-set-key [?\M-0] 'compile)

(global-set-key [?\M-1] 'delete-window)
(global-set-key [?\M-2] 'split-window-vertically)
(global-set-key [?\M-3] 'split-window-horizontally)

;(global-set-key [?\M-f]            'backward-char)

(global-unset-key [?\C-d])
(global-unset-key [?\M-d])
(global-set-key [?\C-d]            'backward-delete-char)
(global-set-key [?\M-d]            'delete-char)

(global-unset-key [?\C-o])
(global-set-key [?\C-o]            'other-window)

(global-unset-key [?\M-o])
(global-set-key [?\M-o]            'next-line-windows)
(global-unset-key [?\M-u])
(global-set-key [?\M-u]            'previous-line-windows)

(global-unset-key [?\C-v])
(global-set-key [?\C-v]            'buffer-menu)

(global-unset-key [?\C-f])
(global-unset-key [?\C-b])
(global-set-key [?\C-f]            'forward-sexp)
(global-set-key [?\C-b]            'backward-sexp)

(global-unset-key [?\M-f])
(global-unset-key [?\M-b])
(global-set-key [?\M-f]            'bookmark-jump)
(global-set-key [?\M-b]            'bookmark-set)

(global-unset-key [?\M-g])
(global-set-key [?\M-g]            'goto-line)

(global-unset-key [?\M-a])
(global-unset-key [?\C-a])
(global-set-key [?\M-a]            'beginning-of-buffer)
(global-set-key [?\C-a]            'beginning-of-line)

(global-unset-key [?\M-e])
(global-unset-key [?\C-e])
(global-set-key [?\M-e]            'end-of-buffer)
(global-set-key [?\C-e]            'end-of-line)

;(global-unset-key [?\M-i])
;(global-set-key [?\M-i]            'string-insert-rectangle)
; Unfortunately, these have to be set in hooks with local-set-key
; (global-unset-key [?\C-i])
; (global-set-key [?\C-i]            'tab-to-tab-stop)

(global-unset-key [?\C-z])
(global-unset-key [?\M-z])
(global-set-key [?\C-z]            'undo)
(global-set-key [?\M-z]            'undo)

(global-unset-key [?\C-s])
(global-unset-key [?\M-s])
(global-unset-key [?\M-r])
(global-set-key [?\C-s]            'isearch-forward-regexp)
(global-set-key [?\M-s]            'query-replace-regexp)
(global-set-key [?\M-r]            'replace-regexp)

;(global-unset-key [?\C-z])
;(global-unset-key [?\M-z])
;(global-set-key [?\C-z]            'copy-region-as-kill)
;(global-set-key [?\M-z]            'kill-region)

(global-unset-key [?\C-t])
(global-set-key [?\C-t]            'set-mark-command)

(global-unset-key [?\C-q])
(global-unset-key [?\M-q])
(global-set-key [?\C-q]            'kill-region)
(global-set-key [?\M-q]            'kill-rectangle-position)

(global-unset-key [?\C-w])
(global-unset-key [?\M-w])
(global-set-key [?\C-w]            'yank)
(global-set-key [?\M-w]            'yank-rectangle-position)
(global-unset-key [?\M-y])
(global-set-key [?\M-y]            'overwrite-mode)

;(global-unset-key [deletechar])
;(global-unset-key "\C[3^")
;(global-set-key [deletechar]            'kill-region)
;(global-set-key "\C[3^"            'kill-rectangle-position)


;(global-unset-key [insert])
;(global-unset-key [shift-<insert>])
;(global-set-key [insert]            'yank)
;(global-set-key [shift-<insert>]    'yank-rectangle-position)

(global-unset-key [?\C-n])
(global-unset-key [?\M-n])
(global-set-key [?\C-n]            'next-line)
(global-set-key [?\M-n]            'scroll-up)

(global-unset-key [?\C-p])
(global-unset-key [?\M-p])
(global-set-key [?\C-p]            'previous-line)
(global-set-key [?\M-p]            'scroll-down)

(global-unset-key [?\C-l])
(global-unset-key [?\M-l])
(global-set-key [?\C-l]            'forward-char)
(global-set-key [?\M-l]            'forward-word)

(global-unset-key [?\C-k])
(global-unset-key [?\M-k])
(global-set-key [?\C-k]            'backward-char)
(global-set-key [?\M-k]            'backward-word)

(defun get-my-tab-length () 3) 

;build a list from 1 to n 
(defun iota 
  (n) 
  (if (= n 0) '() 
    (append (iota (- n 1)) (list n)))) 

;build the tab list 
(defun create-tab-list 
  (length) 
  (mapcar (lambda (n) (* (get-my-tab-length) n)) (iota length))) 

; These functions over-ride the TAB auto-indention:
;(add-hook 'c-mode-hook
;  (function (lambda ()
;    (substitute-key-definition
;    'c-indent-command 'tab-to-tab-stop c-mode-map))))
;
;(add-hook 'c++-mode-hook
;  (function (lambda ()
;   (substitute-key-definition
;    'c-indent-command 'tab-to-tab-stop c++-mode-map))))
;
;(add-hook 'perl-mode-hook
;  (function (lambda ()
;   (substitute-key-definition
;    'perl-indent-command 'tab-to-tab-stop perl-mode-map))))

;; Java Mode
;(autoload 'java-mode "java-mode" "java mode" t nil)

(defun my-c-mode-common-hook ()
  (setq tab-stop-list (create-tab-list 60)) 
  (setq indent-tabs-mode nil)
  (local-unset-key [?\M-7]) 
  (local-set-key [?\M-7] 'gdb) 
;  (define-key c-mode-map "TAB" 'tab-to-tab-stop)
;  (define-key cc-mode-map "TAB" 'tab-to-tab-stop)
;  (define-key c++-mode-map "TAB" 'tab-to-tab-stop)
;  (local-unset-key [TAB])
;  (local-unset-key [?\M-i])
;  (local-set-key [TAB]            'tab-to-tab-stop)

  ; This does the equivalent of the three 'add-hook' functions above: 
  (local-set-key [?\C-i]          'tab-to-tab-stop)

;  (local-set-key [?\M-j]            'backward-word)

  (local-unset-key [?\M-a])
  (local-unset-key [?\C-a])
  (local-set-key [?\M-a]            'beginning-of-buffer)
  (local-set-key [?\C-a]            'beginning-of-line)

  (local-unset-key [?\M-e])
  (local-unset-key [?\C-e])
  (local-set-key [?\M-e]            'end-of-buffer)
  (local-set-key [?\C-e]            'end-of-line)

  (local-unset-key [?\M-q])
  (local-unset-key [?\C-q])
  (local-set-key [?\C-q]            'kill-region)
  (local-set-key [?\M-q]            'kill-rectangle-position)
  
  (setq compile-command "make -j4 ")
;  (local-set-key [?\C-i]          'c-indent-command)
;  (setq tab-width (get-my-tab-length)) 
;  (setq c-basic-offset (get-my-tab-length)) 
;  (setq standard-indent (get-my-tab-length)) 
;  (setq compile-command "make -f ")
  )

;; String pattern for locating errors in maven output. This assumes a Windows drive letter at the beginning
(require 'compile)
(setq compilation-error-regexp-alist
    (append (list
       ;; works for jikes
       '("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):\\([0-9]+\\):[0-9]+:[0-9]+:" 1 2 3)
       ;; works for javac
       '("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):" 1 2)
       ;; works for maven 2.x
       '("^\\(.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3)
       ;; works for maven 2.x in windows
       '("^\\([a-zA-Z]:.*\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\]" 1 2 3)
       ;; works for maven 3.x
       '("^\\(\\[ERROR\\] \\)?\\(/[^:]+\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\]" 2 3 4))
    compilation-error-regexp-alist))

(defun mvnfast()
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setq dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (compile (concat "mvn -f " dir "/pom.xml install -Dmaven.test.skip=true"))))))

(define-key java-mode-map [?\M-0] 'mvnfast)

(add-hook
 'java-mode-hook
 '(lambda () "Treat Java 1.5 @-style annotations as comments."
    (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
    (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))

(defun my-java-mode-hook ()
  (setq tab-stop-list (create-tab-list 60)) 
  (setq tab-width 3)
;  (setq indent-tabs-mode t)
  (setq indent-tabs-mode nil)
  (local-set-key [?\C-i]          'tab-to-tab-stop)
  (local-unset-key [?\M-7]) 
  (local-set-key [?\M-7] 'jdb) 
;  (setq compile-command 'mvnfast)
  )

(defun my-compile-mode-hook ()
  (local-unset-key (kbd "C-."))
  (local-set-key (kbd "C-.") 'control-lock-enable)
  (global-unset-key (kbd "C-."))
  (global-set-key (kbd "C-.") 'control-lock-enable)
  )

(defun my-perl-mode-hook ()
  (setq tab-stop-list (create-tab-list 60)) 
  (setq indent-tabs-mode nil)
  (setq perl-tab-always-indent t)
  (setq tab-width 3)

  (local-set-key [?\C-i]          'tab-to-tab-stop)
  (local-set-key [?\M-j]            'backward-word)
  (local-unset-key [?\M-a])
  (local-set-key [?\M-a]            'beginning-of-buffer)
  
;  k&r style with spacing of 3 instead of 4
;  (setq perl-indent-level 3)

;  These settings indent in the c-mode style. Not sure if a good thing !
  (setq perl-indent-level 0)
  (setq perl-continued-statement-offset 3)
  (setq perl-continued-brace-offset 0)
  (setq perl-brace-offset 0)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'java-mode-hook 'my-java-mode-hook)
;(add-hook 'c++-mode-hook 'my-c-mode-hook)
(add-hook 'perl-mode-hook 'my-perl-mode-hook)
(add-hook 'compile-mode-hook 'my-compile-mode-hook)

;(gud-def my-jdb-command `%c' nil nil)
;(defun my-jdb-command `%c' nil nil)
;(add-hook 'jdb-mode-hook 'my-jdb-command)

; display tabs with a . prefix
(standard-display-ascii ?\t ".\t") 

(setq auto-mode-alist 
   (append 
    (list
     '("\.[mM][aA][kK]$" . makefile-mode)
     '("\.java$" . java-mode)
     '("\.[tT]$" . makefile-mode)
     '("\\.\\([pP][Llm]\\|al\\)$" . perl-mode)
    )auto-mode-alist ))
 
; use cperl mode if perl is in the #!
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))

(put 'upcase-region 'disabled nil)
