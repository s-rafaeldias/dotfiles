(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

;; Auto generated code
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-env-home-directory "~/miniconda3")
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (projectile haskell-mode rainbow-delimiters highlight-parentheses spacemacs-dark spacemacs-theme conda company-anaconda anaconda-mode company-jedi flycheck counsel consuel company evil company-mode wakatime-mode swiper ace-window helm which-key use-package)))
 '(wakatime-cli-path "~/miniconda3/bin/wakatime")
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; (require 'package)
;; (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
;;                     (not (gnutls-available-p))))
;;        (proto (if no-ssl "http" "https")))
;;   (when no-ssl
;;     (warn "\
;; your version of emacs does not support ssl connections,
;; which is unsafe because it allows man-in-the-middle attacks.
;; there are two things you can do about this warning:
;; 1. install an emacs version that does support ssl and be safe.
;; 2. remove this warning from your init file so you won't see it again."))
;;   ;; comment/uncomment these two lines to enable/disable melpa and melpa stable as desired
;;   (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
;;   (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
;;   (when (< emacs-major-version 24)
;;     ;; for important compatibility libraries like cl-lib
;;     (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
;; (package-initialize)


;; ;; Settings
;; (setq inhibit-startup-message t)
;; (setq backup-directory-alist `(("." . "~/.emacs-backups")))
;; (setq mac-command-modifier 'control)
;; (setq indo-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)
;; (defalias 'list-buffers 'ibuffer)
;; (put 'narrow-to-region 'disabled nil)
;; (setq org-preserve-indentation t) 

;; ;; Packages
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))

;; Themes
;; (use-package spacemacs-theme
;;   :defer t
;;   :ensure t
;;   :init (load-theme 'spacemacs-dark t))

;; Wakatime:
;; (use-package wakatime-mode
;;   :ensure t
;;   :config
;;   (progn
;;     (global-wakatime-mode)))

;; Try: test packages without installing
;; (use-package try
;;   :ensure t)

;; (use-package which-key
;;   :ensure t
;;   :config (which-key-mode))

;; ;; Evil mode
;; (use-package evil
;;   :ensure t
;;   :config
;;   (evil-mode 1))
;; (setq-default display-line-numbers 'visual
;;               display-line-numbers-widen t
;;               ;; this is the default
;;               display-line-numbers-current-absolute t)

;; (defun noct:relative ()
;;   (setq-local display-line-numbers 'visual))

;; (defun noct:absolute ()
;;   (setq-local display-line-numbers t))

;; (add-hook 'evil-insert-state-entry-hook #'noct:absolute)
;; (add-hook 'evil-insert-state-exit-hook #'noct:relative)

;; ;; Ace-window
;; (use-package ace-window
;;   :ensure t
;;   :init
;;   (progn
;;     (global-set-key [remap other-window] 'ace-window)
;;     ))

;; ;; Ivy/Swiper/Counsel
;; (use-package swiper
;;   :ensure t)
;; (use-package counsel
;;   :ensure t)
;; (use-package ivy
;;   :ensure t
;;   :config
;;   (progn
;;     (ivy-mode 1)
;;     (setq ivy-use-virtual-buffers t)
;;     (setq enable-recursive-minibuffers t)
;;     ;; enable this if you want `swiper' to use it
;;     ;; (setq search-default-mode #'char-fold-to-regexp)
;;     (global-set-key "\C-s" 'swiper)
;;     (global-set-key (kbd "C-c C-r") 'ivy-resume)
;;     (global-set-key (kbd "<f6>") 'ivy-resume)
;;     (global-set-key (kbd "M-x") 'counsel-M-x)
;;     (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;     (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;;     (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;;     (global-set-key (kbd "<f1> l") 'counsel-find-library)
;;     (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;     (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;;     (global-set-key (kbd "C-c g") 'counsel-git)
;;     (global-set-key (kbd "C-c j") 'counsel-git-grep)
;;     (global-set-key (kbd "C-c k") 'counsel-ag)
;;     (global-set-key (kbd "C-x l") 'counsel-locate)
;;     (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;;     (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)))

;; (use-package projectile
;;   :ensure t
;;   :config
;;   (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;;   (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;;   (projectile-mode +1))

;; Company-mode
;; (use-package company
;;   :ensure t
;;   :config
;;   (progn
;;     (add-hook 'after-init-hook 'global-company-mode)
;;     (company-mode 1)))

;; (use-package highlight-parentheses
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook #'highlight-parentheses-mode))

;; (use-package rainbow-delimiters
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))

;; Python packages
;; (use-package company-jedi
;;   :ensure t)

;; (use-package conda
;;   :ensure t
;;   :config
;;   (progn
;;     (custom-set-variables '(conda-env-home-directory "~/miniconda3"))
;;     (conda-env-initialize-interactive-shells)
;;     (conda-env-autoactivate-mode t)))

;; (use-package company-anaconda
;;   :ensure t
;;   :config (eval-after-load "company"
;; 	  '(add-to-list 'company-backends 'company-anaconda)))

;; Haskell packages
;; (use-package haskell-mode
;;   :ensure t)

;; Auto generated code
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-env-home-directory "~/miniconda3")
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (projectile haskell-mode rainbow-delimiters highlight-parentheses spacemacs-dark spacemacs-theme conda company-anaconda anaconda-mode company-jedi flycheck counsel consuel company evil company-mode wakatime-mode swiper ace-window helm which-key use-package)))
 '(wakatime-cli-path "~/miniconda3/bin/wakatime")
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
