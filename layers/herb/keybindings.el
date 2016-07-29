(spacemacs|add-toggle toggle-shadowsocks-proxy-mode
  :status shadowsocks-proxy-mode
  :on (global-shadowsocks-proxy-mode)
  :off (global-shadowsocks-proxy-mode -1)
  :documentation "Toggle shadowsocks proxy mode."
  :evil-leader "ots")

(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-w" nil)))

(global-set-key (kbd "C-w") 'spacemacs/backward-kill-word-or-region)

(global-set-key (kbd "M-f") 'evil-scroll-page-down)
(global-set-key (kbd "M-b") 'evil-scroll-page-up)
