;;; init-im.el --- Work with input method configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; im

(when (maybe-require-package 'pyim)
  (after-load 'pyim
    (setq default-input-method "pyim")
    (setq pyim-default-scheme 'quanpin)
    (setq pyim-page-length 8)
    (add-hook 'emacs-startup-hook
              #'(lambda () (pyim-restart-1 t)))
    (pyim-isearch-mode 1)
    ))



(when (maybe-require-package 'posframe)
  (after-load 'pyim
    (setq pyim-page-tooltip 'posframe))
  )

(when (maybe-require-package 'pyim-basedict)
  (after-load 'pyim-basedict
    (pyim-basedict-enable))
  )

(provide 'init-im)
;;; init-im.el ends here
