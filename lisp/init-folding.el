;;; init-folding.el --- Support code and region folding -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package origami
  :ensure t
  :bind (("C-c f" . origami-recursively-toggle-node)
         ("C-c F" . origami-toggle-all-nodes))
  :hook (after-init . global-origami-mode))

(provide 'init-folding)
;;; init-folding.el ends here
