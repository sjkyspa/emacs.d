;;; init-local.el --- Work with input method configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; local
(setq backup-by-copying t)
(setq make-backup-files t)
(defvar backup-dir (expand-file-name "~/.emacs.d/backups/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosaves/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

(after-load 'projectile
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

(setq markdown-command "jq --slurp --raw-input '{\"text\": \"\\(.)\", \"mode\": \"gfm\"}' | curl -sS --data @- https://api.github.com/markdown")

(after-load 'org-agenda
  (defvar org-agenda-dir "get org files location")
  (setq-default org-agenda-dir "/datas/boxes/agendas/")
  (setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
  (setq org-agenda-file-gtd (expand-file-name "todos.org" org-agenda-dir))
  (setq org-agenda-file-routine (expand-file-name "routine.org" org-agenda-dir))
  (setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))
  (setq org-default-notes-file (expand-file-name "inbox.org" org-agenda-dir))
  (setq org-agenda-files (list org-agenda-dir)))

;;; use xelatex as latex compiler
(setq org-latex-compiler "xelatex")
;;; default eval the code snip without confirm
(setq org-confirm-babel-evaluate nil)

(add-hook 'org-clock-in-hook
          (lambda ()  (shell-command (concat "curl -s -X POST -d '{"
                                        "\"type\": \"FOCUSED\", "
                                        "\"title\": \"" org-clock-current-task "\","
                                        "\"duration\": \"25\""

                                        "}' "
                                        "127.0.0.1:13140"))))
(add-hook 'org-pomodoro-finished-hook
          (lambda ()  (shell-command (concat "curl -s -X POST -d '{"
                                        "\"type\": \"UNFOCUSED\", "
                                        "\"title\": \"" org-clock-current-task "\","
                                        "\"duration\": \"" (format "%s" (cond ((equal :short-break org-pomodoro-state) org-pomodoro-short-break-length)
                                                                              ((equal :long-break org-pomodoro-state) org-pomodoro-long-break-length))) "\""
                                        "}' "
                                        "127.0.0.1:13140"))))

(add-hook 'org-pomodoro-break-finished-hook
          (lambda ()  (shell-command (concat "curl -s -X POST -d '{"
                                        "\"type\": \"FOCUS\", "
                                        "\"title\": \"" org-clock-current-task "\""
                                        "}' "
                                        "127.0.0.1:13140"))))
(add-hook 'org-pomodoro-killed-hook
          (lambda ()  (shell-command (concat "curl -s -X POST -d '{"
                                        "\"type\": \"UNFOCUSED\", "
                                        "\"title\": \"" org-clock-current-task "\","
                                        "\"duration\": \"5\""
                                        "}' "
                                        "127.0.0.1:13140"))))

(setq-default org-agenda-skip-scheduled-if-done t)


(setq org-capture-templates
      `(("t" "todo" entry (file "")  ; "" => `org-default-notes-file'
         "* NEXT %?\n%U\n" :clock-resume t)
        ("n" "note" entry (file "")
         "* %? :NOTE:\n%U\n%a\n" :clock-resume t)
        ))

(setq org-agenda-custom-commands
      `(("N" "Notes" tags "NOTE"
         ((org-agenda-overriding-header "Notes")
          (org-tags-match-list-sublevels t)))
        ("g" "GTD"
         ((agenda "" nil)
          (tags "INBOX"
                ((org-agenda-overriding-header "Inbox")
                 (org-agenda-skip-function
                  '(lambda ()
                     (or (org-agenda-skip-subtree-if 'todo '("DONE"))
                         (org-agenda-skip-entry-if 'nottodo '("TODO", "NEXT")))))
                 (org-tags-match-list-sublevels t)
                 (org-tags-match-list-sublevels nil)))
          (stuck ""
                 ((org-agenda-overriding-header "Stuck Projects")
                  (org-agenda-tags-todo-honor-ignore-options t)
                  (org-tags-match-list-sublevels t)
                  (org-agenda-todo-ignore-deadlines 'all)
                  (org-agenda-todo-ignore-scheduled 'all)))
          (tags-todo "-INBOX"
                     ((org-agenda-overriding-header "Next Actions")
                      (org-agenda-tags-todo-honor-ignore-options t)
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-todo-ignore-deadlines 'all)
                      (org-agenda-skip-function
                       '(lambda ()
                          (or (org-agenda-skip-subtree-if 'todo '("HOLD" "WAITING"))
                              (org-agenda-skip-entry-if 'nottodo '("NEXT")))))
                      (org-tags-match-list-sublevels t)
                      (org-agenda-sorting-strategy
                       '(todo-state-down effort-up category-keep))))
          (tags-todo "-INBOX/PROJECT"
                     ((org-agenda-overriding-header "Projects")
                      (org-tags-match-list-sublevels t)
                      (org-agenda-sorting-strategy
                       '(category-keep))))
          (tags-todo "-INBOX/-NEXT"
                     ((org-agenda-overriding-header "Orphaned Tasks")
                      (org-agenda-tags-todo-honor-ignore-options t)
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-todo-ignore-deadlines 'all)
                      (org-agenda-skip-function
                       '(lambda ()
                          (or (org-agenda-skip-subtree-if 'todo '("PROJECT" "HOLD" "WAITING" "DELEGATED"))
                              (org-agenda-skip-subtree-if 'nottododo '("TODO")))))
                      (org-tags-match-list-sublevels t)
                      (org-agenda-sorting-strategy
                       '(category-keep))))
          (tags-todo "/WAITING"
                     ((org-agenda-overriding-header "Waiting")
                      (org-agenda-tags-todo-honor-ignore-options t)
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-todo-ignore-deadlines 'all)
                      (org-agenda-sorting-strategy
                       '(category-keep))))
          (tags-todo "/DELEGATED"
                     ((org-agenda-overriding-header "Delegated")
                      (org-agenda-tags-todo-honor-ignore-options t)
                      (org-agenda-todo-ignore-scheduled 'all)
                      (org-agenda-todo-ignore-deadlines 'all)
                      (ORG-agenda-sorting-strategy
                       '(category-keep))))
          (tags-todo "-INBOX"
                     ((org-agenda-overriding-header "On Hold")
                      (org-agenda-skip-function
                       '(lambda ()
                          (or (org-agenda-skip-subtree-if 'todo '("WAITING"))
                              (org-agenda-skip-entry-if 'nottodo '("HOLD")))))
                      (org-tags-match-list-sublevels nil)
                      (org-agenda-sorting-strategy
                       '(category-keep))))
          ;; (tags-todo "-NEXT"
          ;;            ((org-agenda-overriding-header "All other TODOs")
          ;;             (org-match-list-sublevels t)))
          ))))


(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))
(global-set-key [(M C i)] 'aj-toggle-fold)


(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

(defun eshell/gst (&rest args)
  (magit-status (pop args) nil)
  (eshell/echo))   ;; The echo command suppresses output

(provide 'init-local)
;;; init-local.el ends here
