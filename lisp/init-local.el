;;; init-local.el --- Work with input method configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; local

(after-load 'projectile
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map))

(provide 'init-local)
;;; init-local.el ends here
