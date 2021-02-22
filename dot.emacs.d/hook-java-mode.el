;; BEGIN hook-java-mode.el :

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

(defun mvnbuild()
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setq dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (compile (concat "mvn -f " dir "/pom.xml install -Dmaven.test.skip=true"))))))

(defun mvnexec()
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setq dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (term (concat "mvn -f " dir "/pom.xml exec:exec -Dmaven.test.skip=true"))))))

(defun mvndebug()
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setq dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (jdb "jdb -attach 6000")))))
;        (jdb (concat "mvn -f " dir "/pom.xml exec:exec -Dmaven.test.skip=true"))))))

;(define-key java-mode-map [?\M-0] 'mvnbuild)

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
  (local-set-key [?\M-7] 'mvnexec) 
  (local-unset-key [?\M-9]) 
  (local-set-key [?\M-9] 'mvnbuild) 
;  (setq compile-command 'mvnbuild)
  )

;(gud-def my-jdb-command `%c' nil nil)
;(defun my-jdb-command `%c' nil nil)
;(add-hook 'jdb-mode-hook 'my-jdb-command)

(add-hook 'java-mode-hook 'my-java-mode-hook)

;; END hook-java-mode.el :
