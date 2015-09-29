(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'default-frame-alist '(font . "ricty-13.5"))

;; ファイル名、バッファ名の補完をcase-insensitiveに変更
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;;ウィンドウ移動をshift + 矢印にする
(windmove-default-keybindings)

(line-number-mode t)
(column-number-mode t)

;; rainbow-delimiter
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


;; 括弧の色を強調する設定
;; http://qiita.com/megane42/items/ee71f1ff8652dbf94cf7
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

;;折りたたみ
(add-to-list 'hs-special-modes-alist
	     '(ruby-mode
	       "\\(def\\|do\\|{\\)" "\\(end\\|end\\|}\\)" "#"
	       (lambda (arg) (ruby-end-of-block)) nil))
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (hs-minor-mode t)))
(define-key global-map (kbd "C-\\") 'hs-toggle-hiding)

(require 'package)

;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;; Marmaladeを追加
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))

;; 初期化
(package-initialize)

(add-to-list 'load-path "~/.emacs.d")

;;auto-complete
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-auto-show-menu 0.5)
(setq ac-dwim t)
;;(setq ac-use-menu-map t)

;;SQL
(add-hook 'sql-mode-hook 'auto-complete-mode)

;;golang
(require 'go-mode)
(require 'go-autocomplete)
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;;vb.net
(autoload 'vbnet-mode "vbnet-mode" "Mode for editing VB.NET code." t)
   (setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\|vb\\)$" .
                                 vbnet-mode)) auto-mode-alist))

;;ruby
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
;;(autoload 'ruby-mode "ruby-mode"
;;  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.json.jbuilder$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))


;;projectile rails
(require 'projectile)
(projectile-global-mode)

(require 'projectile-rails)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;;ruby-end
(require 'ruby-end)
(add-hook 'enh-ruby-mode-hook
  '(lambda ()
    (abbrev-mode 1)
    (electric-pair-mode t)
    (electric-indent-mode t)
    (electric-layout-mode t)))

;;ruby-block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;;robe
(add-hook 'enh-ruby-mode-hook '(lambda()
			     (robe-mode)
			     ) )
(add-hook 'enh-ruby-mode-hook 'auto-complete-mode)
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
(add-hook 'robe-mode-hook 'ac-robe-setup)
			     
;; web-mode
(require 'web-mode)
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))
(add-hook 'web-mode-hook 'web-mode-hook)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; scss-mode
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil) ))
(add-hook 'scss-mode-hook
	  '(lambda() (scss-custom)))

;; coffee-mode
(require 'coffee-mode)
(defun coffee-custom ()
  "coffee-mode-hook"
  (and
   (set (make-local-variable 'tab-width) 2)
   (set (make-local-variable 'coffee-tab-width) 2) ))
(add-hook 'coffee-mode-hook
	  '(lambda() (coffee-custom)))

;;browse-kill-ring
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(load-theme 'hc-zenburn t)

;;undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; set font and screen
(progn
  
  ;; 背景色を設定します。
  (add-to-list 'default-frame-alist '(background-color . "black"))
  
)










