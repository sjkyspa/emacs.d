;;; init-typescript.el --- Work with typescript configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; typescript

(defun setup-tide-mode()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(when (maybe-require-package 'tide)
  (after-load 'tide
    (setq company-tooltip-align-annotations t)
    (add-hook 'before-save-hook 'tide-format-before-save)
    (add-hook 'typescript-mode-hook #'setup-tide-mode)
    ))


(provide 'init-typescript)
;;; init-typescript.el ends here
