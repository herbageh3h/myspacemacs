;;; packages.el --- herb Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq herb-packages
    '(
      ;; package names go here
      (unicad :location local)
      ;;browse-kill-ring
      keyfreq
      ranger
      evil-surround
      plsql
      ;;sqlup-mode
      ))

;; List of packages to exclude.
(setq herb-excluded-packages '())

(defun herb/init-unicad ()
  (use-package unicad))

(defun herb/init-keyfreq ()
  (use-package keyfreq
    :init
    (progn
      (keyfreq-mode 1)
      (keyfreq-autosave-mode 1))))

(defun herb/post-init-ranger()
  (setq ranger-cleanup-eagerly t)
  (setq ranger-show-dotfiles t)
  )

(defun herb/post-init-evil-surround()
  (global-evil-surround-mode 1)
  )

;; (defun herb/init-sqlup-mode()
;;   (use-package sqlup-mode))

;; For each package, define a function herb/init-<package-name>
;;
;; (defun herb/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
