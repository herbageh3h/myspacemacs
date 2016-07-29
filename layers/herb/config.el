;;-*- Emacs-Lisp -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; init-herb-keys.el
;; -----------------
;; 设置我常用的快捷键，一般在所有初始化工作完成以后再调用该脚本进行设置
;;
;; Author: Huang Hao
;; Created: 2015-08-23
;; Updated: 2015-08-23
;;
;; Usage: 
;; Add the following script to your .emacs file.
;; (require 'init-herb-keys)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-prefix-command 'herb-map)
(global-set-key (kbd "C-;") 'herb-map)

;; set alternative key for setting mark
(global-set-key (kbd "C-.") 'set-mark-command)

;; bind delete previous character key
(global-set-key (kbd "C-z") 'delete-backward-char)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-regionkj)

;;toggle-truncate-line command
(global-set-key (kbd "C-\\") 'toggle-truncate-lines)

;; occur key
(global-set-key (kbd "C-c o") 'occur)
;; View occurrence in occur mode
(define-key occur-mode-map (kbd "v") 'occur-mode-display-occurrence)
(define-key occur-mode-map (kbd "n") 'next-line)
(define-key occur-mode-map (kbd "p") 'previous-line)

;; compare windows
(global-set-key (kbd "C-c w") 'compare-windows)

;; fill region
(global-set-key (kbd "C-c f") 'fill-region)

;; insert date
(global-set-key (kbd "C-c d") 'insert-date)

;; revert buffer
(global-set-key (kbd "C-c g") 'revert-buffer)

;; next-buffer
(global-set-key (kbd "M-]") 'next-buffer)

;; prev-buffer
(global-set-key (kbd "M-[") 'previous-buffer)

;; rectangle insert
(global-set-key (kbd "C-x r i") 'string-insert-rectangle)

;; delete-whole-line
(global-set-key (kbd "C-d") 'kill-whole-line)

;; delete-char
(global-set-key (kbd "M-d") 'delete-char)
(global-set-key (kbd "M-k") 'kill-word)

;; delete-region
(global-set-key (kbd "C-c C-k") 'delete-region)

;; forward-whitespace
(global-set-key (kbd "C-; C-f") 'forward-whitespace)

;; Window switching
(windmove-default-keybindings) ;; Shift+direction

;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)
(global-set-key (kbd "C-h c") 'describe-char)

;; Completion at point
(global-set-key (kbd "C-'") 'completion-at-point)

;; Find files by name and display results in dired
(global-set-key (kbd "M-j") 'find-name-dired)

;; a few key bindings are replaced with more powerful equivalents.
;; coming from better-defaults. 2015-08-23
(global-set-key (kbd "C-x C-b") 'ibuffer)  ;; ibuffer instead of list-buffer
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)
(global-set-key (kbd "M-z") 'zap-up-to-char) ;; zap-up-to-char instead of zap-to-char
(global-set-key (kbd "C-s") 'isearch-forward-regexp) ;; swapped with regex-aware incremental search functions.
(global-set-key (kbd "C-M-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)

;; split window effectively
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-o") 'other-window)

(defun my-duplicate-line()
  "Copy the current line to the next row."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "C-; C-n") 'my-duplicate-line)

(defun my-move-to-next-line()
  "Move the current line to below the next line."
  (interactive)
  (kill-whole-line)
  (next-line 1)
  (move-beginning-of-line 1)
  (yank)
  (previous-line 1)
)
(global-set-key (kbd "M-n") 'my-move-to-next-line)

(defun my-move-to-previous-line()
  "Move the current line to above the previous line."
  (interactive)
  (kill-whole-line)
  (previous-line 1)
  (move-beginning-of-line 1)
  (yank)
  (previous-line 1)
)
(global-set-key (kbd "M-p") 'my-move-to-previous-line)

(defun my-move-first-real-char()
  "Move to the first char that is not space or tab character in the current line."
  (interactive)
  (move-beginning-of-line 1)
  (skip-chars-forward "[\t ]")
  )
(global-set-key (kbd "C-; C-a") 'my-move-first-real-char)

(defun my-delete-white-space()
  "Delete the following white space in the current line."
  (interactive)
  (set-mark (point))
  (forward-whitespace 1)
  (delete-region (mark) (point))
  )
(global-set-key (kbd "M-m") 'my-delete-white-space)

(defun my-backward-white-space()
  "Backward skip white space"
  (interactive)
  (if (re-search-backward "[ \t]+\\|\n" nil 'move)
	  (or (eq (char-after (match-beginning 0)) ?\n)
	      (skip-chars-backward " \t")))
  )
(global-set-key (kbd "C-; C-b") 'my-backward-white-space)

(defun my-mark-current-line()
  "Mark the current line."
  (interactive)
  (let ((end-point))
    (my-move-first-real-char)
    (push-mark (point) nil t)
    (save-excursion 
      (move-end-of-line 1)
      (setq end-point (point)))
    (goto-char end-point))
  )
(global-set-key (kbd "C-; C-l") 'my-mark-current-line)

(defun my-mark-current-word()
  "Mark current word between forward and backward whitespace."
  (interactive)
  (my-backward-white-space)
  (skip-chars-forward "[\t \n]")
  (push-mark-command nil nil)
  (setq cua--explicit-region-start t)
  (forward-whitespace 1)
  (skip-chars-backward "[\t \n]")
  (setq mark-active t))
(global-set-key (kbd "C-; C-m") 'my-mark-current-word)

(defun my-fill-region-seq(beg end)
  "set the numbers of the region in sequences."
  (interactive (list (point) (mark)))
  (unless (and beg end)
    (error "The mark is not set now, so there is no region"))
  ;;(let ((my-text (filter-buffer-substring beg end nil)))
  ;;  (message my-text))
  (let ((pos-beg beg) (pos-end end) field-width answer times)
    (when (> pos-beg pos-end)
      (setq pos-beg end)
      (setq pos-end beg))
      (save-excursion
        (goto-char pos-beg)
        (save-match-data
          (when (re-search-forward "[0-9]+" pos-end t)
          (setq times (string-to-number (match-string 0) 10)))
          (while (re-search-forward "[0-9]+" pos-end t)
            (setq field-width (- (match-end 0) (match-beginning 0)))
            (setq times (1+ times))
            (replace-match (format (concat "%0" (int-to-string field-width) "d") times)))))))

(defun my-fill-rect-seq(beg end)
  "set the numbers of the region in sequences."
  (interactive "*r")
  (unless (and beg end)
    (error "The mark is not set now, so there is no region"))
  ;;(let ((my-text (filter-buffer-substring beg end nil)))
  ;;  (message my-text))
  (let ((pos-beg beg) (pos-end end) field-width answer times startcol endcol startpos endpos (flag nil))
    (when (> pos-beg pos-end)
      (setq pos-beg end)
      (setq pos-end beg))
    (save-excursion
      (goto-char pos-beg)
      (setq startcol (current-column))
      (goto-char pos-end)
      (setq endcol (current-column))
      (goto-char pos-beg)
      (when (< endcol startcol)
        (let ((tempcol startcol))
          (setq startcol endcol endcol tempcol)))
      (setq startpos pos-beg)
      (save-match-data
        (while (and (< (point) pos-end) (not flag))
          (save-excursion
            (move-to-column endcol t)
            (setq endpos (point)))
          (if (re-search-forward "[0-9]+" endpos t)
              (and (setq times (string-to-number (match-string 0) 10))
                   (setq flag t))
            (and (forward-line 1)
                 (move-to-column startcol t))))
        (while (< (point) pos-end)
          (save-excursion
            (move-to-column endcol t)
            (setq endpos (point)))
          (while (re-search-forward "[0-9]+" endpos t)
            (setq field-width (- (match-end 0) (match-beginning 0)))
            (setq times (1+ times))
            (replace-match (format (concat "%0" (int-to-string field-width) "d") times)))
          (forward-line 1)
          (move-to-column startcol t))))))

(defun xah-new-empty-buffer ()
  "Open a new empty buffer.
URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2015-06-12"
  (interactive)
  (let ((両buf (generate-new-buffer "untitled")))
    (switch-to-buffer 両buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))
(setq initial-major-mode (quote text-mode))
(global-set-key (kbd "C-; C-c") 'xah-new-empty-buffer)

(setq dired-listing-switches "-Al")
(setq-default diredp-hide-details-initially-flag nil
              dired-dwim-target t) ;; copy from one dired dir to the next dired dir shown in a split window

(global-set-key (kbd "C-; C-'") 'mc/edit-lines)
(global-set-key (kbd "C-; C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-; C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-; C-/") 'mc/mark-all-like-this)

(setq socks-server '("Default server" "127.0.0.1" 1080 5))

(setq ranger-override-dired t)

;; Capitalize keywords in SQL mode
(add-hook 'sql-mode-hook 'sqlup-mode)
;; Capitalize keywords in an interactive session (e.g. psql)
(add-hook 'sql-interactive-mode-hook 'sqlup-mode)
;; Set a global keyword to use sqlup on a region
(global-set-key (kbd "C-c u") 'sqlup-capitalize-keywords-in-region)
