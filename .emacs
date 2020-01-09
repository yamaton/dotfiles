(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Don't show startup splash screen
(setq inhibit-startup-message t)

;; Disable bell function
;(setq ring-bell-function 'ignore)

;; Emphasize the parentheses
(show-paren-mode t)

;; No tabs! Spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Set tab width to four spaces
(setq-default tab-width 4)

;; Soft Tabs (whitespace tabs)
(require 'whitespace)
(setq whitespace-style 'tabs)

;; Set Line spacing
(setq default-line-spacing 0.32)

;; Show line numbers
; (global-linum-mode nil)

;; Emacs Load Path
;; http://stackoverflow.com/questions/24779041/disable-warning-about-emacs-d-in-load-path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;; Save autosave files (i.e. #foo#) in one place,
;; not to scatter them all over the directories.
;; http://snarfed.org/space/gnu%20emacs%20backup%20files
(defvar autosave-dir
 (concat "~/.emacs.d/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)
(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))
(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; Save backup files (ie "foo~") in one place.
(defvar backup-dir (concat "~/.emacs.d/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Set my name and email address (for ChangeLog Memo)
(setq user-full-name "yamato")
(setq user-mail-address "yamaton@gmail.com")

;; clmemo-mode (changelog Memo)
;;  Open with new entry:  C-x M
;;
(autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
(define-key ctl-x-map "M" 'clmemo)
(setq clmemo-file-name "~/OneDrive/Personal/dailylog.txt")
(setq clmemo-time-string-with-weekday t)
(setq clmemo-title-list
    '("research" "office" "python"  "diary" "study"
    "emacs" "tennis" "gdgd" "log" "schedule" "todo" "memo"))

;; use color for selecting region
(setq transient-mark-mode t)

;; Comment/Uncomment region
(global-set-key "\C-cc" 'comment-dwim)

;; ;; Disable Toolbar
;; (tool-bar-mode -1)

;; Yes-or-No to y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Customize dired
(setq dired-listing-switches "-alk")

;;; bind RET to py-newline-and-indent
(add-hook 'python-mode-hook '(lambda ()
     (define-key python-mode-map "\C-m" 'newline-and-indent)))


;;; PYTHONPATH
(setenv "PYTHONPATH" "~/miniconda3/bin")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (clmemo org-journal)))
 '(rst-block-face (quote font-lock-keyword-face))
 '(rst-emphasis1-face
   (if
       (facep
        (quote italic))
       (quote
        (quote italic))
     (quote italic)))
 '(rst-emphasis2-face (if (facep (quote bold)) (quote (quote bold)) (quote bold)))
 '(rst-level-face-base-color "grey18")
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; Disable beep
(setq visible-bell t)

;; Automatically close parenthesis (like TextMate!)
;(require 'autopair)
;(autopair-global-mode)

;; Set size and position of emacs frame
;; http://ilovett.com/blog/emacs/emacs-frame-size-position
(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))
;; And this is the optimal, without menu, for Macbook Air 2011
(when (window-system) (arrange-frame 90 56 1 22))


;; Markdown mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))


;; my-insert-date
(defvar current-date-format "%b %d, %Y (%a)"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%H:%M"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date ()
  "insert the current date into the current buffer."
  (interactive)
  (insert (format-time-string current-date-format (current-time)))
  (insert "\n"))

(defun insert-current-time ()
  "insert the current date into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time)))
  (insert "\n"))

;(global-set-key "\C-c\C-d" 'insert-current-date)
;(global-set-key "\C-c\C-t" 'insert-current-time)

;; journal
;; http://www.emacswiki.org/emacs/Journal
;; (load "journal")
;; (if (file-directory-p "~/OneDrive/Personal/diary/")
;;     (setq-default journal-dir "~/OneDrive/Personal/diary/"))

;; package already included in 25.1??
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (package-initialize)
)


;; disable menu bar
(unless (string-prefix-p "Aquamacs" (version))
  (menu-bar-mode -1)
)
