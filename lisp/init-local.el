;;; init-local.el --- Work with input method configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; local
(setq-default make-backup-files nil)

(after-load 'projectile
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

(setq markdown-command "jq --slurp --raw-input '{\"text\": \"\\(.)\", \"mode\": \"gfm\"}' | curl -sS --data @- https://api.github.com/markdown")

(provide 'init-local)
;;; init-local.el ends here
