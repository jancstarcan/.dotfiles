(setq frame-inhibit-implied-resize t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-22"))

(add-to-list 'default-frame-alist
             '(background-color . "#181818"))
(add-to-list 'default-frame-alist
             '(foreground-color . "#E4E4EF"))

(setq initial-frame-alist default-frame-alist)
