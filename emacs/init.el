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
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
)
(package-initialize)

(setq vc-follow-symlinks t)

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

(use-package org
  :ensure org-plus-contrib)

(delete-file "~/.emacs.d/config.el")
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-inject-dependencies-at-jack-in nil)
 '(conda-env-home-directory "~/miniconda3")
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (org-bullets editorconfig spaceline-segments spaceline spaceline-config yaml-mode auto-dim-other-buffers elpy counsel-projectile smartparens all-the-icons-dired all-the-icons-dired-mode aggressive-indent cider clojure-mode evil-magit flycheck-golangci-lint git-gutter magit doom-modeline go-mode all-the-icons ivy-rich alchemist lsp-haskell company-lsp dumb-jump iedit which-key wakatime-mode use-package try spacemacs-theme rainbow-delimiters projectile org-plus-contrib highlight-parentheses helm haskell-mode flycheck evil counsel conda company-jedi company-anaconda ace-window)))
 '(wakatime-cli-path "~/miniconda3/bin/wakatime")
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
