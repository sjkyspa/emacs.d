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
    (setq-default pyim-default-scheme 'quanpin)
    (setq-default pyim-page-length 5)
    (pyim-isearch-mode 1)
    (setq pyim-page-tooltip 'posframe)
    (setq-default pyim-english-input-switch-functions
                  '(pyim-probe-dynamic-english
                    pyim-probe-isearch-mode
                    pyim-probe-program-mode
                    pyim-probe-org-structure-template))
    (setq-default pyim-punctuation-half-width-functions
                  '(pyim-probe-punctuation-line-beginning
                    pyim-probe-punctuation-after-punctuation))
    (setq default-input-method "pyim")
    (global-set-key (kbd "C-\\") 'toggle-input-method)
    (global-set-key (kbd "M-j") 'pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
    (global-set-key (kbd "M-f") 'pyim-forward-word)
    (global-set-key (kbd "M-b") 'pyim-backward-word)
    )



  (add-hook 'emacs-startup-hook
            #'(lambda () (pyim-restart)))

  )


(provide 'init-im)
;;; init-im.el ends here
