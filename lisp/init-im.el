;;; init-im.el --- Work with input method configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; im

(require-package 'pyim)
(require-package 'pyim-basedict)
(require-package 'posframe)
(require 'pyim)
(after-load 'pyim
  (pyim-basedict-enable)
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
  (global-set-key (kbd "M-b") 'pyim-backward-word))

(add-hook 'emacs-startup-hook #'(lambda () (pyim-restart)))

(setq rime_share_data_dir (expand-file-name "/Library/Input Methods/Squirrel.app/Contents/SharedSupport"))
(setq rime_user_data_dir (expand-file-name "~/.emacs.d/rime"))
(add-to-list 'load-path "~/.emacs.d/libeirme/build")
(load "~/.emacs.d/liberime/build/liberime.so")

(require 'liberime)
(defun setup-liberime()
  ;;; incase hooks not running
  (interactive)
  (liberime-start rime_share_data_dir rime_user_data_dir)
  (liberime-select-schema "luna_pinyin_simp")
  (setq pyim-default-scheme 'rime-quanpin)
  )
;; work with pyim
(add-hook 'pyim-load-hook 'setup-liberime) ;; or set with use-package

(provide 'init-im)
;;; init-im.el ends here
