;; BEGIN init-global-keys

;(global-set-key [?\M-1] 'help-command) 
;toggle breakpoint is: \C-c \C-a \C-b 
;(global-set-key [?\M-0] 'tmm-menubar)
(global-set-key [?\M-1] 'delete-window)
(global-set-key [?\M-2] 'split-window-vertically)
(global-set-key [?\M-3] 'split-window-horizontally)
(global-set-key [?\M-4] 'string-insert-rectangle) 
(global-set-key [?\M-5] (lambda () (interactive) (my-color-theme-hook)))
(global-set-key [?\M-6] 'list-packages)
(global-set-key [?\M-7] 'tmm-menubar) 
(global-set-key [?\M-8] "\M-x shell") 

;(global-set-key [?\M-f]            'backward-char)

; Use o globally to switch windows
(global-unset-key [?\C-o])
(global-unset-key [?\C-O])
(global-set-key [?\C-o] 'other-window)
(global-set-key [?\C-O] 'other-window)
(global-unset-key [?\M-o])
(global-unset-key [?\M-O])
(global-set-key [?\M-o] 'other-window)
(global-set-key [?\M-O] 'other-window)

(global-unset-key [?\C-d])
(global-unset-key [?\M-d])
;(global-set-key [?\C-d]            'backward-delete-char)
(global-set-key [?\C-d]            'delete-char)
(global-set-key [?\M-d]            'delete-char)

;(global-unset-key [?\M-o])
;(global-set-key [?\M-o]            'next-line-windows)
;(global-unset-key [?\M-u])
;(global-set-key [?\M-u]            'previous-line-windows)

(global-unset-key [?\C-v])
(global-set-key [?\C-v]            'clipboard-yank)

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
;(global-unset-key [?\C-i])
;(global-set-key [?\C-i]            'tab-to-tab-stop)

(global-unset-key [?\C-z])
(global-unset-key [?\M-z])
(global-set-key [?\C-z]            'undo)
(global-set-key [?\M-z]            'undo)

(global-unset-key [?\C-s])
(global-unset-key [?\M-s])
(global-unset-key [?\M-r])
(global-set-key [?\C-s]            'swiper)
(global-set-key [?\M-s]            'query-replace-regexp)
(global-set-key [?\M-r]            'replace-regexp)

;(global-unset-key [?\C-z])
;(global-unset-key [?\M-z])
;(global-set-key [?\C-z]            'copy-region-as-kill)
;(global-set-key [?\M-z]            'kill-region)

(global-unset-key [?\C-t])
(global-set-key [?\C-t]            'buffer-menu)

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

;; END init-global-keys:
