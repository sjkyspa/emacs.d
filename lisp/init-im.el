;;; init-im.el --- Work with input method configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; im

;; (maybe-require-package 'pyim)
;; (maybe-require-package 'pyim-basedict)
;; (maybe-require-package 'posframe)

;; (add-hook 'emacs-startup-hook
;;           #'(lambda () (pyim-restart)))

;; (after-load 'pyim
;;   (setq-default default-input-method "pyim")
;;   (setq-default pyim-default-scheme 'quanpin)
;;   (setq-default pyim-page-length 8)
;;   (pyim-isearch-mode 1)
;;   )


;; (after-load 'pyim
;;   (setq pyim-page-tooltip 'posframe))

;; (after-load 'pyim-basedict
;;(pyim-basedict-enable))


(when (maybe-require-package 'pyim)
  (require-package 'pyim-basedict)
  (require 'pyim)
  (require 'pyim-basedict)
  (require 'posframe)

  (pyim-basedict-enable)

  (after-load 'pyim
    (setq-default default-input-method "pyim")
    (setq-default pyim-default-scheme 'quanpin)
    (setq-default pyim-page-length 8)
    (pyim-isearch-mode 1)
    (setq pyim-page-tooltip 'posframe)
    )



  (add-hook 'emacs-startup-hook
            #'(lambda () (pyim-restart)))

  )


(provide 'init-im)
;;; init-im.el ends here
