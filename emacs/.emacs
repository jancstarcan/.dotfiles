(setq custom-file "~/.custom")
(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'default-frame-alist '(font . "Iosevka-20"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(electric-indent-mode 1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(setq-default indent-tabs-mode t)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(ido-mode 1)
(ido-everywhere 1)

(setq inhibit-startup-screen t)
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

(require 'move-text)
(move-text-default-bindings)

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

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

(setq eglot-events-buffer-size 0)
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

  (setq company-auto-complete nil)
  (global-company-mode 1)
  (global-set-key (kbd "C-c C-SPC") #'company-complete))

(with-eval-after-load 'company
  (setq company-backends '(company-capf)))
