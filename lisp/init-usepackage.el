;;; init-usepackage.el --- usepackage config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; cn

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(provide 'init-usepackage)
;;; init-usepackage.el ends here
