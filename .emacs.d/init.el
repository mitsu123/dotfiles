(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)
        user-init-file (locate-user-emacs-file "init.el")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "M-<RET>") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-;") 'helm-mini)
(global-set-key (kbd "C-'") 'helm-show-kill-ring)
(global-set-key (kbd "C-M-;") 'helm-projectile)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-.") 'helm-find-files)
(global-set-key (kbd "C-,") 'helm-buffers-list)
(global-set-key (kbd "C-:") 'helm-rg)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-M-i") 'company-complete)
(global-set-key (kbd "<f8>") 'neotree-toggle)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-h") nil)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "M-d") 'company-show-doc-buffer))

(with-eval-after-load 'helm
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (define-key helm-map (kbd "C-h") nil))

(with-eval-after-load 'helm-files
  (define-key helm-find-files-map (kbd "C-<backspace>") nil)
  (define-key helm-read-file-map (kbd "C-<backspace>") nil))

(with-eval-after-load 'isearch
  (define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch))

(with-eval-after-load 'key-chord
  (setq key-chord-two-keys-delay 0.05
        key-chord-one-keys-delay 0.05)
  (key-chord-define-global "u8" 'dabbrev-expand)
  (key-chord-define-global "-=" 'flycheck-list-errors)
  (key-chord-define-global "q2" 'query-replace)
  (key-chord-define-global "q3" 'vr/query-replace)
  (key-chord-define-global "q4" 'align)
  (key-chord-define-global "09" (lambda ()
                                  (interactive)
                                  (switch-to-buffer "*scratch*")))
  (key-chord-define-global "0-" (lambda ()
                                  (interactive)
                                  (switch-to-buffer (other-buffer))))
  (key-chord-define-global "]\\" (lambda ()
                                  (interactive)
                                  (setq truncate-lines (not truncate-lines)))))

(with-eval-after-load 'text-mode
  (define-key text-mode-map (kbd "TAB") 'self-insert-command))

(add-hook 'after-init-hook
          (lambda ()
            (exec-path-from-shell-initialize)
            (yas-global-mode)
            (key-chord-mode 1)
            (let ((dir (locate-user-emacs-file "local-lisp")))
              (when (file-exists-p dir)
                (dolist (file (directory-files dir t "\\.el\\'"))
                  (load file))))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-highlight-search t)
 '(auto-save-file-name-transforms
   (\`
    (("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'"
      (\,
       (concat temporary-file-directory "\\2"))
      t)
     ("\\`/\\([^/]*/\\)*\\([^/]*\\)\\'"
      (\,
       (concat temporary-file-directory "\\2"))
      t))))
 '(column-number-mode t)
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(company-selection-wrap-around t)
 '(company-transformers (quote (company-sort-by-backend-importance)))
 '(create-lockfiles nil)
 '(custom-enabled-themes (quote (wombat)))
 '(default-frame-alist (quote ((vertical-scroll-bars) (alpha . 97))))
 '(delete-selection-mode t)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(global-company-mode t)
 '(global-undo-tree-mode t)
 '(global-whitespace-mode t)
 '(helm-display-function (quote pop-to-buffer))
 '(helm-mini-default-sources
   (quote
    (helm-source-bookmarks helm-source-recentf helm-source-buffers-list helm-source-files-in-current-dir)))
 '(helm-mode t)
 '(ibuffer-always-show-last-buffer :nomini)
 '(ibuffer-expert t)
 '(ibuffer-formats
   (quote
    ((mark modified read-only locked " "
           (name 30 30 :left :elide)
           " "
           (size 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename))))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(ns-pop-up-frames nil)
 '(ns-use-fullscreen-animation nil)
 '(ns-use-native-fullscreen nil)
 '(package-selected-packages
   (quote
    (helm-c-yasnippet helm-rg neotree yasnippet yasnippet-snippets visual-regexp exec-path-from-shell flycheck ag wgrep-ag undo-tree company helm-projectile shackle projectile helm key-chord)))
 '(projectile-completion-system (quote helm))
 '(projectile-mode t nil (projectile))
 '(recentf-auto-cleanup (quote never))
 '(recentf-max-saved-items 99999)
 '(recentf-mode t)
 '(ring-bell-function (quote ignore))
 '(scroll-bar-mode nil)
 '(scroll-error-top-bottom t)
 '(scroll-step 1)
 '(shackle-default-size 0.4)
 '(shackle-inhibit-window-quit-on-same-windows t)
 '(shackle-mode t)
 '(shackle-rules
   (quote
    (("*Completions*" :align
      (quote below))
     ("*Flycheck errors*" :align
      (quote below))
     ("\\*helm" :regexp t :select t :align
      (quote below)))))
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(use-dialog-box nil)
 '(wgrep-enable-key "e")
 '(whitespace-space-regexp "\\(　+\\)")
 '(whitespace-style
   (quote
    (face trailing tabs spaces empty space-before-tab tab-mark))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#002b37"))))
 '(company-scrollbar-fg ((t (:background "#4cd0c1"))))
 '(company-tooltip ((t (:foreground "#36c6b0" :background "#244f36"))))
 '(company-tooltip-common ((t (:foreground "white" :background "#244f36"))))
 '(company-tooltip-common-selection ((t (:foreground "white" :background "#007771"))))
 '(company-tooltip-selection ((t (:foreground "#a1ffcd" :background "#007771"))))
 '(cursor ((t (:background "red1"))))
 '(whitespace-empty ((t (:background "gray20" :foreground "firebrick")))))
