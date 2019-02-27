;;; init-local.el --- Work with input method configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; local
(setq-default make-backup-files nil)

(after-load 'projectile
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

(setq markdown-command "jq --slurp --raw-input '{\"text\": \"\\(.)\", \"mode\": \"gfm\"}' | curl -sS --data @- https://api.github.com/markdown")

(setq-default org-agenda-dir "/datas/nuts/1si/orgs/agendas")
(setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
(setq org-agenda-file-gtd (expand-file-name "todos.org" org-agenda-dir))
(setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
(setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))
(setq org-default-notes-file (expand-file-name "notes.org" org-agenda-dir))
(setq org-agenda-files (list org-agenda-dir))
(setq org-latex-compiler "xelatex")
(setq org-confirm-babel-evaluate nil)

(add-hook 'org-clock-in-hook
          (lambda ()  (shell-command (concat "curl -X POST -d '{"
                                        "\"type\": \"FOCUSED\", "
                                        "\"title\": \"" org-clock-current-task "\""
                                        "}' "
                                        "127.0.0.1:13140"))))
(add-hook 'org-pomodoro-finished-hook
          (lambda ()  (shell-command (concat "curl -X POST -d '{"
                                        "\"type\": \"UNFOCUSED\", "
                                        "\"title\": \"" org-clock-current-task "\","
                                        "\"duration\": \"" (format "%s" (cond ((equal :short-break org-pomodoro-state) org-pomodoro-short-break-length)
                                                                              ((equal :long-break org-pomodoro-state) org-pomodoro-long-break-length))) "\""
                                        "}' "
                                        "127.0.0.1:13140"))))

(add-hook 'org-pomodoro-break-finished-hook
          (lambda ()  (shell-command (concat "curl -X POST -d '{"
                                        "\"type\": \"FOCUS\", "
                                        "\"title\": \"" org-clock-current-task "\""
                                        "}' "
                                        "127.0.0.1:13140"))))



(provide 'init-local)
;;; init-local.el ends here
