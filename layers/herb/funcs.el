(define-minor-mode
   shadowsocks-proxy-mode
   :global t
   :init-value nil
   :lighter " SS"
   (if shadowsocks-proxy-mode
       (setq url-gateway-method 'socks)
     (setq url-gateway-method 'native)))

(define-global-minor-mode
  global-shadowsocks-proxy-mode shadowsocks-proxy-mode shadowsocks-proxy-mode
  :group 'shadowsocks-proxy)

(defun spacemacs/backward-kill-word-or-region (&optional arg)
  "Calls `kill-region' when a region is active and
`backward-kill-word' otherwise. ARG is passed to
`backward-kill-word' if no region is active."
  (interactive "p")
  (if (region-active-p)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word arg)))

(defun herb/indent-buffer()
  "Indent current buffer."
  (interactive)
  (indent-region (point-min) (point-max)))
