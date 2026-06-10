(setq custom-file "~/.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))
(setq load-prefer-newer t)

(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/auto-save/" t)))
(setq create-lockfiles nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-18"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(electric-indent-mode 1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq vc-follow-symlinks t)
(setq dired-dwim-target t)
(setq case-replace nil)

(savehist-mode 1)
(repeat-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(defalias 'yes-or-no-p 'y-or-n-p)

(use-package gruber-darker-theme
  :ensure t
  :init
  (load-theme 'gruber-darker))

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides nil))

(use-package consult
  :ensure t
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("M-y" . consult-yank-pop)
   ("C-c r" . consult-ripgrep)))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(global-set-key (kbd "<escape>") 'ignore)

(global-set-key (kbd "C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-,") 'mc/mark-all-like-this)

(global-set-key (kbd "M-.") #'xref-find-definitions)
(global-set-key (kbd "M-,") #'xref-go-back)
(global-set-key (kbd "C-c C-r") #'eglot-rename)
(global-set-key (kbd "C-c C-f") #'eglot-format)
(global-set-key (kbd "C-c k") #'eldoc-box-help-at-point)
(global-set-key (kbd "C-c h") #'eldoc-doc-buffer)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c C-c") 'recompile)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "C-c C-n")
			  #'dired-create-empty-file))
(setq dired-listing-switches "-alh")

(use-package magit
  :ensure t)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "PATH"))

(defun duplicate-line ()
  (interactive)
  (save-excursion
    (let ((text (buffer-substring (line-beginning-position)
                                  (line-end-position))))
      (end-of-line)
      (newline)
      (insert text))))

(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") 'duplicate-line)

(use-package avy
  :ensure t)
(global-unset-key (kbd "M-j"))
(global-set-key (kbd "M-j") 'avy-goto-char)
(global-unset-key (kbd "M-k"))
(global-set-key (kbd "M-k") 'avy-goto-line)

(use-package move-text
  :ensure t
  :bind
  (("M-p" . move-text-up)
   ("M-n" . move-text-down)))
(use-package multiple-cursors
  :ensure t)
(use-package wrap-region
  :ensure t
  :config
  (wrap-region-global-mode t))

(use-package expand-region
  :ensure t)

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(use-package rainbow-mode
  :ensure t
  :hook ((prog-mode css-mode html-mode vue-ts-mode) . rainbow-mode))

(use-package nasm-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package glsl-mode
  :ensure t)

(use-package python-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package typst-ts-mode
  :ensure t)

(use-package typst-preview
  :ensure t)

(use-package csharp-mode
  :ensure t)

(use-package csproj-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package css-mode
  :ensure t)

(use-package lua-mode
  :ensure t)

(add-to-list 'major-mode-remap-alist
             '(typescript-mode . typescript-ts-mode))
(add-to-list 'major-mode-remap-alist
             '(css-mode . css-ts-mode))
(add-to-list 'major-mode-remap-alist
             '(rust-mode . rust-ts-mode))

(setq treesit-language-source-alist
      '((c "https://github.com/tree-sitter/tree-sitter-c")
		(rust "https://github.com/tree-sitter/tree-sitter-rust")
		(c3 "https://github.com/c3lang/tree-sitter-c3")
		(typst "https://github.com/uben0/tree-sitter-typst")
		(cpp "https://github.com/tree-sitter/tree-sitter-cpp")
		(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
		(css "https://github.com/tree-sitter/tree-sitter-css")
		(vue "https://github.com/ikatyang/tree-sitter-vue")))

(add-to-list 'load-path "~/.emacs.d/c3")
(require 'c3-ts-mode)
(setq c3-ts-mode-indent-offset 4)

(add-to-list 'load-path "~/.emacs.d/vue-ts-mode")
(require 'vue-ts-mode)

(setq vue-ts-mode-indent-offset 4)
(setq typescript-ts-mode-indent-offset 4)
(setq css-ts-mode-indent-offset 4)

(use-package eglot
  :ensure t
  :hook ((c-mode . eglot-ensure)
		 (c++-mode . eglot-ensure)
		 (csharp-mode . eglot-ensure)
		 (rust-mode . eglot-ensure)
		 (glsl-mode . eglot-ensure)
		 (nasm-mode . eglot-ensure)
		 (python-mode . eglot-ensure)
		 (typescript-mode . eglot-ensure)
		 (css-mode . eglot-ensure)
		 (vue-ts-mode . eglot-ensure)
		 (lua-mode . eglot-ensure))

  :config
  (setq eglot-stay-out-of '(flymake))
  (add-to-list 'eglot-server-programs
			   '((c-mode c++-mode c-ts-mode c++-ts-mode) . ("clangd")))
  (add-to-list 'eglot-server-programs
			   '((csharp-mode) . ("omnisharp" "-lsp")))
  (add-to-list 'eglot-server-programs
			   '((rust-mode rust-ts-mode) . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs
			   '((python-mode) . ("pylsp")))
  (add-to-list 'eglot-server-programs
			   '(typescript-mode . ("typescript-language-server" "--stdio")))
  (setq-default eglot-workspace-configuration
				'((pylsp
				   (plugins
					(black (enabled t)))))))

(setq eglot-events-buffer-config 0)

(add-hook 'eglot-managed-mode-hook
		  (lambda ()
			(eglot-inlay-hints-mode -1)))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay nil
		company-minimum-prefix-length 9999)

  (setq company-insertion-on-trigger nil)
  (global-company-mode 1)
  (global-set-key (kbd "C-c C-SPC") #'company-complete))

(with-eval-after-load 'company
  (setq company-backends '(company-capf)))

(use-package eldoc-box
  :ensure t
  :config
  (setq eldoc-box-clear-with-C-g t))
