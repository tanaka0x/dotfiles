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

(add-to-list 'load-path "~/.emacs.d/elisps")

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

;; Helm
(el-get-bundle! dash)
(el-get-bundle! helm
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files))

(el-get-bundle helm-ag)
(el-get-bundle helm-projectile
  (helm-projectile-on))

;; Magit
(el-get-bundle magit)

;; browse-kill-ring
(defun setup-browse-kill-ring ()
    (define-key browse-kill-ring-mode-map (kbd "C-g") 'browse-kill-ring-quit))
(el-get-bundle browse-kill-ring
  (global-set-key (kbd "M-y") 'browse-kill-ring)
  (add-hook 'browse-kill-ring-hook 'setup-browse-kill-ring))

;; rainbow-delimiters
(el-get-bundle rainbow-delimiters)

;; hc-zenburn
(el-get-bundle elpa:hc-zenburn-theme
  (load-theme 'hc-zenburn t))

;; flycheck
(el-get-bundle flycheck)

;; completion
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(global-set-key (kbd "C-M-i") 'company-complete)

(el-get-bundle company-mode
  (add-hook 'emacs-lisp-mode-hook 'company-mode))

(setq web-mode-code-indent-offset 2)
(defun setup-web-mode-with-jsx ()
  (web-mode)
  (company-mode)
  (tern-mode)
  (flycheck-mode)
  (flycheck-select-checker 'javascript-eslint))

(el-get-bundle web-mode
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . setup-web-mode-with-jsx))
  (add-hook 'web-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'web-mode-hook #'electric-pair-mode))

;; javascript
(setq js-indent-level 2)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)
(el-get-bundle felipeochoa/rjsx-mode
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . rjsx-mode))
  (add-to-list 'interpreter-mode-alist '("node" . rjsx-mode)))

(el-get-bundle js2-mode
  ;; (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
  ;; (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
  (add-hook 'js2-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'js2-mode-hook #'electric-pair-mode))

(el-get-bundle company-tern)

(defun setup-js2-mode ()
  (company-mode)
  (tern-mode)
  (flycheck-mode))

(add-hook 'js2-mode-hook 'setup-js2-mode)
(add-hook 'js2-jsx-mode-hook 'setup-js2-mode)

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-tern))

(el-get-bundle! go-mode)
(require 'company-go)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda()
           (add-hook 'before-save-hook' 'gofmt-before-save)
           (local-set-key (kbd "M-.") 'godef-jump)
           (set (make-local-variable 'company-backends) '(company-go))
           (company-mode)))

;; Vagrant
(el-get-bundle vagrant-tramp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (company-go hc-zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
