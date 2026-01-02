;; -*- lexical-binding: t; -*-
(setq custom-file "~/.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))
(setq load-prefer-newer t)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'default-frame-alist '(font . "Iosevka-18"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(electric-indent-mode 1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq vc-follow-symlinks t)

(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(ido-mode 1)
(ido-everywhere 1)

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(global-set-key (kbd "C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-,") 'mc/mark-all-like-this)

(global-set-key (kbd "C-x p") 'previous-buffer)
(global-set-key (kbd "C-x n") 'next-buffer)

(global-set-key (kbd "M-.") #'xref-find-definitions)
(global-set-key (kbd "M-,") #'xref-find-references)
(global-set-key (kbd "C-c C-r") #'eglot-rename)
(global-set-key (kbd "C-c C-f") #'eglot-format-buffer)

(global-set-key (kbd "C-c c") 'compile)
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(global-set-key (kbd "C-c C-d") 'duplicate-line)

(use-package vterm
  :ensure t)

(use-package move-text
  :ensure t)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(load-file "~/.emacs.d/c3-ts-mode.el")
(setq c3-ts-mode-indent-offset 4)
(setq treesit-font-lock-level 4)

(use-package eglot
  :ensure t
  :hook ((c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
		 (lisp-mode . eglot-ensure))
  :config
  (setq eglot-workspace-configuration
        '((:clangd .
           (:fallbackFlags ["--std=c++23"]
            :completionStyle "detailed"
            :pchStorage "memory")))))

(setq eglot-events-buffer-config 0)
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (eglot-inlay-hints-mode -1)))

(add-hook 'c-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format-buffer nil t)))

(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format-buffer nil t)))

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
