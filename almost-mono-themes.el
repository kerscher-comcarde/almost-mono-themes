;;; almost-mono-themes.el --- Almost monochromatic color themes -*- lexical-binding: t; -*-

;; Copyright (C) 2019, 2020 John Olsson

;; Author: John Olsson <john@cryon.se>
;; Maintainer: John Olsson <john@cryon.se>
;; URL: https://github.com/cryon/almost-mono-themes
;; Created: 9th May 2019
;; Version: 1.0.0
;; Keywords: faces
;; Package-Requires: ((emacs "24"))

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.

;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A suite of almost monochrome Emacs themes

;;; Code:

(defconst almost-mono-themes-colors
  '((white . ((background . "#ffffff")
	      (foreground . "#000000")
	      (weak	  . "#888888")
	      (weaker	  . "#dddddd")
	      (weakest    . "#efefef")
	      (highlight  . "#fda50f")
	      (warning	  . "#ff0000")
	      (success	  . "#00ff00")
	      (string     . "#3c5e2b")))

    (black . ((background . "#000000")
	      (foreground . "#ffffff")
	      (weak	  . "#aaaaaa")
	      (weaker	  . "#666666")
	      (weakest	  . "#222222")
	      (highlight  . "#fda50f")
	      (warning	  . "#ff0000")
	      (success	  . "#00ff00")
	      (string     . "#a7bca4")))

    (gray .  ((background . "#2b2b2b")
	      (foreground . "#ffffff")
	      (weak	  . "#aaaaaa")
	      (weaker	  . "#666666")
	      (weakest	  . "#222222")
	      (highlight  . "#fda50f")
	      (warning	  . "#ff0000")
	      (success	  . "#00ff00")
	      (string     . "#a7bca4")))

    (cream . ((background . "#f0e5da")
	      (foreground . "#000000")
	      (weak	  . "#7d7165")
	      (weaker	  . "#c4baaf")
	      (weakest    . "#dbd0c5")
	      (highlight  . "#fda50f")
	      (warning	  . "#ff0000")
	      (success	  . "#00ff00")
	      (string     . "#3c5e2b")))))

(defmacro almost-mono-themes--variant-with-colors (variant &rest body)
  "Execute BODY in a scope where the different colors for given VARIANT is bound."
  `(let* ((colors (or (cdr (assoc ,variant almost-mono-themes-colors))
		      (error "No such theme variant")))
	  (background (cdr (assoc 'background colors)))
	  (foreground (cdr (assoc 'foreground colors)))
	  (weak	      (cdr (assoc 'weak colors)))
	  (weaker     (cdr (assoc 'weaker colors)))
	  (weakest    (cdr (assoc 'weakest colors)))
	  (highlight  (cdr (assoc 'highlight colors)))
	  (warning    (cdr (assoc 'warning colors)))
	  (success    (cdr (assoc 'success colors)))
	  (string     (cdr (assoc 'string colors))))
     ,@body))

(defmacro almost-mono-themes--faces-spec ()
  "Provide the faces specification."
  (quote
   (mapcar
    (lambda (entry) (list (car entry) `((t ,@(cdr entry)))))
    `(

      ;; default
      (default (:background ,background :foreground ,foreground))
      (fringe  (:background ,background))
      (region  (:background ,highlight  :foreground ,foreground))
      (show-paren-match (:background ,background :foreground ,success :bold t))
      (show-paren-mismatch (:background ,background :foreground ,warning :bold t))
      (minibuffer-prompt (:weight bold :foreground ,foreground))
      (isearch (:background ,weak :foreground ,foreground :bold t))
      (lazy-highlight (:background ,weaker :foreground ,foreground))
      (link (:underline t))

      ;; mode line
      (mode-line (:box (:line-width -1 :color ,weaker)
		       :background ,weakest :foreground ,foreground))

      (mode-line-inactive (:box (:line-width -1 :color ,weaker)
				:background ,background :foreground ,weaker))

      ;; font lock
      (font-lock-keyword-face (:bold t))
      (font-lock-function-name-face (:bold t))
      (font-lock-variable-name-face (:foreground ,foreground))
      (font-lock-warning-face (:foreground ,foreground :underline (:color ,warning :style wave)))
      (font-lock-builtin-face (:bold t))
      (font-lock-variable-name-face (:foreground ,foreground :italic t))
      (font-lock-constant-face (:bold t :italic t))
      (font-lock-type-face (:italic t))
      (font-lock-preprocessor-face (:italic t))
      (font-lock-comment-face (:foreground ,weak :italic t))
      (font-lock-string-face (:foreground ,string))
      (font-lock-doc-face (:inherit font-lock-comment-face))
      (line-number (:foreground ,weaker))
      (linum (:inherit line-number))
      (vertical-border (:foreground ,weaker))

      ;; eshell
      (eshell-prompt (:foreground ,foreground :bold t))
      (eshell-ls-directory (:foreground ,foreground :bold t))
      (eshell-ls-archive (:inherit eshell-ls-unreadable))
      (eshell-ls-backup (:inherit eshell-ls-unreadable))
      (eshell-ls-clutter (:inherit eshell-ls-unreadable))
      (eshell-ls-executable (:inherit eshell-ls-unreadable))
      (eshell-ls-missing (:inherit eshell-ls-unreadable))
      (eshell-ls-product (:inherit eshell-ls-unreadable))
      (eshell-ls-readonly (:inherit eshell-ls-unreadable))
      (eshell-ls-special (:inherit eshell-ls-unreadable))
      (eshell-ls-symlink (:inherit eshell-ls-unreadable))

      ;; company mode
      (company-tooltip (:background ,weakest :foreground ,foreground))
      (company-tooltip-selection (:background ,weaker :foreground ,foreground))
      ;;(company-tooltip-search (:background "#ff0000" :foreground "#00ff00"))
      (company-tooltip-common (:bold t))
      (company-tooltip-common-selection (:bold t))
      (company-scrollbar-bg (:background ,weaker))
      (company-scrollbar-fg (:background ,weak))
      (company-tooltip-annotation-selection (:background ,weaker :foreground ,foreground :italic t))
      (company-tooltip-annotation (:background ,weakest :foreground ,weak :italic t))

      ;; git gutter
      (git-gutter:modified (:background ,highlight :foreground ,highlight))
      (git-gutter:added (:background ,success :foreground ,success))
      (git-gutter:deleted (:background ,warning :foreground ,warning))

      ;; diff hl
      (diff-hl-change (:background ,highlight :foreground ,highlight))
      (diff-hl-insert (:background ,success :foreground ,success))
      (diff-hl-delete (:background ,warning :foreground ,warning))

      ;; hl line
      (hl-line (:background ,weakest))
      (highlight-current-line-face (:inherit hl-line))

      ;; ido
      (ido-first-match (:bold t))
      (ido-only-match (:bold t))
      (ido-subdir (:italic t))
      (ido-virtual (:foreground ,weak))
      (ido-vertical-match-face (:bold t :italic nil))

      ;; org mode
      (org-table (:foreground ,weak))

      ;; speedbar
      (speedbar-button-face (:foreground ,weakest))
      (speedbar-directory-face (: ,foreground))
      (speedbar-file-face (:foreground ,foreground))
      (speedbar-highlight-face (:foreground ,highlight))
      (speedbar-selected-face (:background ,weaker :foreground ,foreground))
      (speedbar-separator-face (:foreground ,foreground))
      (speedbar-tag-face (:foreground ,weak))
      
      ;; helm
      (helm-action (:foreground ,foreground))
      (helm-header (:background ,background :foreground ,highlight :bold t))
      (helm-selection (:background ,weaker :foreground ,foreground))
      (helm-buffer-not-saved (:foreground ,weak))
      (helm-candidate-number (:inherit helm-action))
      (helm-selection-line (:inherit helm-selection))
      (helm-match-item (:inherit helm-minibuffer-prompt))
      (helm-header-line-left-margin (:inherit helm-action))
      (helm-source-header (:inherit helm-action))
      (helm-buffer-file (:inherit helm-action))
      (helm-buffer-directory (:inherit helm-action))
      (helm-buffer-process (:inherit helm-action))
      (helm-buffer-size (:inherit helm-action))
      (helm-ff-directory (:inherit helm-action))
      (helm-ff-invalid-symlink (:inherit helm-buffer-not-saved))
      (helm-ff-prefix (:inherit helm-action))
      (helm-ff-symlink (:inherit helm-action))
      (helm-history-remote (:inherit helm-action))
      (helm-history-deleted (:inherit helm-action))
      (helm-visible-mark (:inherit helm-selection))
      (helm-separator (:inherit helm-buffer-not-saved))
      (helm-prefarg (:inherit helm-action))
      (helm-M-x-key (:inherit helm-buffer-not-saved))
      (helm-match (:inherit helm-header))
      (helm-buffer-archive (:inherit helm-buffer-not-saved))
      (helm-buffer-saved-out (:inherit helm-action))
      (helm-buffer-modified (:inherit helm-header))
      (helm-no-file-buffer-modified (:inherit helm-header))
      (helm-lisp-completion-info (:inherit helm-selection))
      (helm-lisp-show-completion (:inherit helm-selection))
      (helm-delete-async-message (:inherit helm-buffer-not-saved))
      (helm-ff-denied (:inherit helm-buffer-not-saved))
      (helm-ff-dotted-directory (:inherit helm-action))
      (helm-ff-dotted-symlink-directory (:inherit helm-action))
      (helm-ff-file-extension (:inherit helm-action))
      (helm-ff-pipe (:inherit helm-action))
      (helm-ff-rsync-progress (:inherit helm-action))
      (helm-ff-socket (:inherit helm-action))
      (helm-ff-history (:inherit helm-buffer-not-saved))
      (helm-history-deleted (:inherit helm-buffer-not-saved))
      (helm-ff-suid (:inherit helm-action))
      (helm-history-remote (:inherit helm-buffer-not-saved))
      (helm-ff-executable (:inherit helm-action))
      (helm-etags-file (:inherit helm-action))

      ;; magit
      (magit-bisect-bad (:inherit default))
      (magit-bisect-good (:inherit default))
      (magit-bisect-skip (:inherit default))
      (magit-blame-date (:inherit default))
      (magit-blame-hash (:inherit default))
      (magit-blame-heading (:inherit default))
      (magit-blame-name (:inherit default))
      (magit-blame-summary (:inherit default))
      (magit-branch-current (:inherit default))
      (magit-branch-local (:inherit default))
      (magit-branch-remote (:inherit default))
      (magit-cherry-equivalent (:inherit default))
      (magit-cherry-unmatched (:inherit default))
      (magit-diff-base (:background nil :foreground ,highlight))
      (magit-diff-base-highlight (:inherit magit-diff-base))
      (magit-diff-added (:background nil :foreground ,success))
      (magit-diff-added-highlight (:inherit default))
      (magit-diff-conflict-heading (:inherit default))
      (magit-diff-context (:inherit default))
      (magit-diff-context-highlight (:inherit magit-diff-base))
      (magit-diff-file-heading (:inherit default))
      (magit-diff-file-heading-highlight (:inherit default))
      (magit-diff-file-heading-selection (:inherit default))
      (magit-diff-lines-boundary (:inherit default))
      (magit-diff-lines-heading (:inherit default))
      (magit-diff-removed (:background nil :foreground ,warning))
      (magit-diff-whitespace-warning (:inherit magit-diff-removed))
      (magit-diffstat-added (:inherit magit-diff-added))
      (magit-diffstat-removed (:inherit magit-diff-removed))
      (magit-dimmed (:background nil :foreground ,weaker))
      (magit-filename (:inherit default))
      (magit-hash (:inherit default))
      (magit-head (:inherit default))
      (magit-log-author (:inherit default))
      (magit-log-date (:inherit default))
      (magit-log-graph (:inherit default))
      (magit-popup-argument (:inherit default))
      (magit-popup-disabled-argument (:inherit default))
      (magit-popup-header (:inherit default))
      (magit-popup-key (:inherit default))
      (magit-popup-option-value (:inherit default))
      (magit-process-ng (:inherit default))
      (magit-process-ok (:inherit default))
      (magit-reflog-amend (:inherit default))
      (magit-reflog-checkout (:inherit default))
      (magit-reflog-cherry-pick (:inherit default))
      (magit-reflog-commit (:inherit default))
      (magit-reflog-merge (:inherit default))
      (magit-reflog-other (:inherit default))
      (magit-reflog-rebase (:inherit default))
      (magit-reflog-remote (:inherit default))
      (magit-reflog-reset (:inherit default))
      (magit-refname (:inherit default))
      (magit-refname-stash (:inherit default))
      (magit-refname-wip (:inherit default))
      (magit-section-heading (:inherit default))
      (magit-section-highlight (:inherit default))
      (magit-sequence-done (:inherit default))
      (magit-sequence-drop (:inherit default))
      (magit-sequence-head (:inherit default))
      (magit-sequence-onto (:inherit default))
      (magit-sequence-part (:inherit default))
      (magit-sequence-pick (:inherit default))
      (magit-sequence-stop (:inherit default))
      (magit-signature-bad (:inherit magit-diff-removed))
      (magit-signature-good (:inherit default))
      (magit-signature-expired (:inherit magit-signature-bad))
      (magit-signature-expired-key (:inherit magit-signature-bad))
      (magit-signature-error (:inherit magit-signature-bad))
      (magit-signature-revoked (:inherit magit-signature-bad))
      (magit-signature-untrusted (:inherit default))
      (magit-tag (:inherit default))
      ))))


(defun almost-mono-themes--variant-name (variant)
  "Create symbol for color theme variant VARIANT."
  (intern (format "almost-mono-%s" (symbol-name variant))))

(defmacro almost-mono-themes--define-theme (variant)
  "Define a theme for the almost-mono variant VARIANT."
  (let ((name (almost-mono-themes--variant-name variant))
        (doc (format "almost mono theme (%s version)" variant)))
    `(progn
       (deftheme ,name ,doc)
       (put ',name 'theme-immediate t)
       (almost-mono-themes--variant-with-colors
        ',variant
        (apply 'custom-theme-set-faces ',name
               (almost-mono-themes--faces-spec)))
       (provide-theme ',name))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
	       (file-name-as-directory (file-name-directory load-file-name))))

(provide 'almost-mono-themes)

;;; almost-mono-themes.el ends here
