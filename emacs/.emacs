
(setq custom-file "~/.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))
(setq load-prefer-newer t)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/auto-save/" t)))

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

(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(defalias 'yes-or-no-p 'y-or-n-p)

(use-package ido-completing-read+
  :ensure t)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(global-set-key (kbd "C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-,") 'mc/mark-all-like-this)

(global-set-key (kbd "M-.") #'xref-find-definitions)
(global-set-key (kbd "M-,") #'xref-find-references)
(global-set-key (kbd "C-c C-r") #'eglot-rename)
(global-set-key (kbd "C-c C-f") #'eglot-format-buffer)
(global-set-key (kbd "C-c k") #'eldoc-box-help-at-point)
(global-set-key (kbd "C-c h") #'eldoc-doc-buffer)
(global-set-key (kbd "C-c c") 'compile)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "C-c C-n")
    #'dired-create-empty-file))

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

(use-package move-text
  :ensure t)


(add-hook 'text-mode-hook
          (lambda ()
            (local-set-key (kbd "M-p") #'move-text-up)
            (local-set-key (kbd "M-n") #'move-text-down)))

(add-hook 'prog-mode-hook
          (lambda ()
            (local-set-key (kbd "M-p") #'move-text-up)
            (local-set-key (kbd "M-n") #'move-text-down)))

(use-package expand-region
  :ensure t)

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(use-package rainbow-mode
  :ensure t
  :hook ((prog-mode css-mode html-mode) . rainbow-mode))

(load-file "~/.emacs.d/c3-ts-mode.el")
(setq c3-ts-mode-indent-offset 4)
(setq treesit-font-lock-level 4)

(use-package glsl-mode
  :ensure t)

(use-package eglot
  :ensure t
  :hook ((c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
		 (lua-ts-mode . eglot-ensure)
		 (lisp-mode . eglot-ensure)
		 (glsl-mode . eglot-ensure)
		 (nasm-mode . eglot-ensure))
  :config
  (setq eglot-workspace-configuration
        '((:clangd .
           (:fallbackFlags ["--std=c++23"]
            :completionStyle "detailed"
            :pchStorage "memory")))))

(setq eglot-events-buffer-config 0)
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode c-ts-mode c++-ts-mode) . ("clangd"))))

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (eglot-inlay-hints-mode -1)))
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (flymake-mode -1)))

(global-set-key (kbd "C-c d") #'flymake-show-buffer-diagnostics)

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
