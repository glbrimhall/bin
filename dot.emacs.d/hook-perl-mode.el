;; BEGIN hook-perl-model.el

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

; use cperl mode if perl is in the #!
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))

(add-hook 'perl-mode-hook 'my-perl-mode-hook)

;; END hook-perl-model.el
