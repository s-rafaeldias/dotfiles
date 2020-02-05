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

(setq custom-file "~/.emacs.d/custom.el")

(delete-file "~/.emacs.d/config.el")
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
