(setq user-full-name "Jiaqi Wang"
      user-mail-address "w.jiaqi004@gmail.com")

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 24))

(setq doom-theme 'doom-palenight)

(set-frame-parameter (selected-frame)'alpha '(97 . 97))
(add-to-list 'default-frame-alist'(alpha . (97 . 97)))

(setq display-line-numbers-type 'relative)

(setq doom-themes-treemacs-theme 'doom-colors)
(setq treemacs-width 25)
;; (map! :leader
;;       :desc "Open treemacs" "o p" #'treemacs-display-current-project-exclusively)

(map! :leader
      :desc "Org Babel tangle" "m B" #'org-babel-tangle)
(after! org-superstar
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-superstar-prettify-item-bullets t))
(after! org
  ;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-directory "~/org/"
        org-agenda-files '("~/org/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-log-done 'time
        ;; org-hide-emphasis-markers t
        ))
(add-hook 'org-mode-hook 'turn-on-auto-fill)
;; (add-hook 'org-mode-hook 'centered-window-mode)

;; (customize-set-variable 'fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x" "::" "<>" "++" "--" "and" "or")) ;; List of ligatures to turn off
;; (add-hook 'prog-mode-hook (lambda ()
;;                             (unless (eq major-mode 'web-mode)
;;                             (fira-code-mode))))
;; (plist-put! +ligatures-extra-symbols
;;   org
;;   :name          "»"
;;   :src_block     "»"
;;   :src_block_end "«"
;;   :quote         "“"
;;   :quote_end     "”"
;;   ;; Functional
;;   :lambda        "λ"
;;   :def           "ƒ"
;;   :composition   "∘"
;;   :map           "↦"
;;   ;; Types
;;   :null          "∅"
;;   :true          "𝕋"
;;   :false         "𝔽"
;;   :int           "ℤ"
;;   :float         "ℝ"
;;   :str           "𝕊"
;;   :bool          "𝔹"
;;   :list          "𝕃"
;;   ;; Flow
;;   :not           "￢"
;;   :in            "∈"
;;   :not-in        "∉"
;;   :and           "and"
;;   :or            "or"
;;   :for           "∀"
;;   :some          "∃"
;;   :return        "⟼"
;;   :yield         "⟻"
;;   ;; Other
;;   :union         "⋃"
;;   :intersect     "∩"
;;   :diff          "∖"
;;   :tuple         "⨂"
;;   :pipe          "" ;; FIXME: find a non-private char
;;   :dot           "•"  ;; you could also add your own if you want
;; )

;; TODO replace C-c prefix with something else so that no functionality is lost
(map! :map evil-insert-state-map "C-c" 'evil-normal-state)
(map! :map evil-normal-state-map "C-c" 'evil-normal-state)

(map! :desc "Comment or uncomment current line"
    "C-/" #'comment-line)
(map! :desc "Drag selected line up"
      "M-k" #'drag-stuff-up)
(map! :desc "Drag selected line down"
      "M-j" #'drag-stuff-down)

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

(setq evil-move-cursor-back nil)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\vendor\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\node_modules\\'"))
  ;; (add-to-list 'lsp-file-watch-ignored-files "[/\\\\]\\.my-files\\'"))

(setq default-input-method "bulgarian-phonetic")
(map! :leader
      :desc "Toggle input method" "t i" #'toggle-input-method)

(map! :leader
      :desc "Increment at pointer"
      :map evil-normal-state-map
      "=" #'evil-numbers/inc-at-pt)

(map! :leader
      :desc "Decrement at pointer"
      :map evil-normal-state-map
      "-" #'evil-numbers/dec-at-pt)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(setq delete-by-moving-to-trash t
      undo-limit 80000000
      evil-want-fine-undo t
      ;; truncate-string-ellipsis "…"
      scroll-margin 10
      )

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window=split evil-window-vsplit)
  (consult-buffer))
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window=split evil-window-split)
  (consult-buffer))

(after! company
  (setq company-idle-delay 0.8
        company-minimum-prefix-length 2)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

(setq projectile-ignored-projects '("~/" "/tmp" "~/.emacs.d" "~/.emacs.d/.local/straight/repos/"))
(defun projectile-ignored-project-function (filepath)
  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

(use-package! aas
  :commands aas-mode)

(setq yas-triggers-in-field t)
(setq yas--default-user-snippets-dir "~/.config/doom/snippets")

;; (setq web-mode-engines-alist
;;       '(("php"    . "\\\\.phtml\\\\'")
;;         ("blade"  . "\\\\.blade\\\\.")))
;; (add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
;; (add-to-list 'auto-mode-alist '("/\\(views\\|html\\|templates\\)/.*\\.php\\'" . web-mode))
(setq web-mode-comment-style 2)

;; (defun emacs-smart-quit
;;     (interactive)
;;   (if ())
;;   )
(evil-ex-define-cmd "q" (lambda () (interactive) (switch-to-buffer "*doom*")))
(map! :leader
      :desc "go to dashboard" "g d" (lambda () (interactive) (switch-to-buffer "*doom*")))

;; (after! persp-mode
;;   (setq persp-emacsclient-init-frame-behaviour-override "main"))

(map! :leader
      :desc "Toggle Center the window" "w c" #'centered-window-mode)

(setq +file-templates-dir "~/.config/doom/templates"
      max-specpdl-size 10000)
(set-file-template! "\\.cpp$" :trigger "__cp.cpp" :mode 'c++-mode)

(defun my-c++-mode-hook ()
  (setq c-basic-offset 2)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(add-hook 'c++-mode-hook
    (lambda ()
    (unless (or (file-exists-p "makefile")
                (file-exists-p "Makefile"))
        (set (make-local-variable 'compile-command)
            (concat "g++ -o run "
                    (if buffer-file-name
                        (shell-quote-argument
                        (buffer-file-name))))))))

;; (electric-pair-mode 1)

;; (defvar org-electric-pairs '((?\* . ?\*) (?/ . ?/) (?= . ?=)
;;                             (?\_ . ?\_) (?~ . ?~) (?+ . ?+)) "Electric pairs for org-mode.")

;; (defun org-add-electric-pairs ()
;;   (setq-local electric-pair-pairs (append electric-pair-pairs org-electric-pairs))
;;   (setq-local electric-pair-text-pairs electric-pair-pairs))

;; (add-hook 'org-mode-hook 'org-add-electric-pairs)
