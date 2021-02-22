;; BEGIN c-mode-hook:

(defun my-c-mode-common-hook ()
  (setq tab-stop-list (create-tab-list 60)) 
  (setq indent-tabs-mode nil)
  (local-unset-key [?\M-7]) 
  (local-set-key [?\M-7] 'gdb) 
  (local-unset-key [?\M-8]) 
  (local-set-key [?\M-8] '"\C-c \C-a \C-b") 
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

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; END c-mode-hook:
