;; BEGIN hook-webxml-mode.el

;; BEGIN web-mode-hook

(defun web-init ()
  (setq web-mode-ac-sources-alist
      '(("php" . (ac-source-yasnippet ac-source-php-auto-yasnippets))
        ("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
        ("css" . (ac-source-css-property ac-source-emmet-css-snippets))))

(add-hook 'web-mode-before-auto-complete-hooks
          '(lambda ()
             (let ((web-mode-cur-language
                    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
                   (yas-activate-extra-mode 'php-mode)
                 (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
                   (setq emmet-use-css-transform t)
                                  (setq emmet-use-css-transform nil)))))
)

;(defun web-config ()
;
;  (local-unset-key [?\M-0]) 
;  (local-set-key [?\M-0] (kbd "C-c C-f"))
;  (local-unset-key [?\M-9]) 
;  (local-set-key [?\M-9] 'auto-complete)
;  (define-key ac-mode-map (kbd "M-9") 'auto-complete)
;  (setq web-mode-enable-comment-keywords t)
;  (setq web-mode-markup-indent-offset 2)
;  (setq web-mode-enable-block-face t)
;  (setq web-mode-enable-auto-pairing t)
;  (setq web-mode-enable-css-colorization t)
;  (setq web-mode-enable-block-face t)
;  (setq web-mode-enable-current-element-highlight t)
;  ;(setq web-mode-enable-current-column-highlight t)
;  (set-face-attribute 'web-mode-folded-face nil :foreground "Pink3")
;  ;(set-face-attribute 'web-mode-folded-face nil :foreground "Pink3")
;
;  ;for some reasont his causes better high-lighting
;  )

;; END web-mode-hook
;; BEGIN nxml-mode-hook

;(require 'auto-complete-nxml)
;;; Keystroke to popup help about something at point.
;(setq auto-complete-nxml-popup-help-key "C-:")
;;; Keystroke to toggle on/off automatic completion.
;(setq auto-complete-nxml-toggle-automatic-key "C-c C-t")
;
;(require 'hideshow)
;(require 'sgml-mode)
;(require 'nxml-mode)
;
;(add-to-list 'hs-special-modes-alist
;             '(nxml-mode
;               "<!--\\|<[^/>]*[^/]>"
;               "-->\\|</[^/>]*[^/]>"
;
;               "<!--"
;               sgml-skip-tag-forward
;               nil))
;
;(add-hook 'nxml-mode-hook 'hs-minor-mode)
;(define-key nxml-mode-map (kbd "M-0") 'hs-toggle-hiding)
;
;;; optional key bindings, easier than hs defaults
;(defun my-nxml-mode-hook ()
;
;  (local-unset-key [?\M-0]) 
;  (local-set-key [?\M-0] 'hs-toggle-hiding)
;  (local-unset-key [?\M-9]) 
;  (local-set-key [?\M-9] 'auto-complete)
;)
;
;(add-hook 'nxml-mode-hook 'my-nxml-mode-hook)
;
;; END nxml-mode-hook
