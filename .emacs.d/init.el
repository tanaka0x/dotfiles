;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq-default indent-tabs-mode nil)
(add-to-list 'default-frame-alist '(font . "ricty-24"))

;; windmove
(windmove-default-keybindings 'meta)
(global-set-key (kbd "ESC <up>") 'windmove-up)
(global-set-key (kbd "ESC <down>") 'windmove-down)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <left>") 'windmove-left)

;; el-get
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; hc-zenburn
(el-get-bundle elpa:hc-zenburn-theme
  (load-theme 'hc-zenburn t))

;; flycheck
(el-get-bundle flycheck)

;; completion
(el-get-bundle company-mode)

(setq web-mode-code-indent-offset 2)
(defun setup-web-mode-with-jsx ()
  (web-mode)
  (company-mode)
  (tern-mode)
  (flycheck-mode)
  (flycheck-select-checker 'javascript-eslint))

(el-get-bundle web-mode
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . setup-web-mode-with-jsx)))

;; javascript
(setq js-indent-level 2)
(el-get-bundle js2-mode
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(el-get-bundle company-tern)

(add-hook 'js2-mode-hook 'company-mode)
(add-hook 'js2-mode-hook 'tern-mode)
(add-hook 'js2-mode-hook 'flycheck-mode)
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-tern))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" default)))
 '(package-selected-packages (quote (hc-zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
