;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "/Volumes/PortableSSD/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(setq doom-theme 'doom-tokyo-night)
(setq doom-font (font-spec :family "Maple Mono NF CN" :size 17)
      doom-variable-pitch-font (font-spec :family "LXGW Bright" :size 17))

(setq org-directory "~/org/")

(setq display-line-numbers-type 'relative)

(xterm-mouse-mode 1)

(map!
 :map evil-visual-state-map
 "Y" (lambda () (interactive) (evil-yank (region-beginning) (region-end) nil ?+) (evil-normal-state))
 )

(map!
 "s-v" 'clipboard-yank)

(setq select-enable-clipboard nil)

(use-package! just-mode)

(use-package! rime
  :config
  (setq rime-librime-root "/opt/homebrew/opt/librime/")
  (setq default-input-method "rime")
  (setq rime-emacs-module-header-root  "/opt/homebrew/Cellar/emacs-plus@30/30.2/include"))

(setq rime-user-data-dir "~/Library/Rime")

(add-hook 'org-mode-hook 'org-fragtog-mode)

(use-package! emt
  :hook (after-init . emt-mode))

(use-package! laas
  :hook ((LaTeX-mode . laas-mode) (org-mode . laas-mode))
  :config ; do whatever here
  (aas-set-snippets 'laas-mode
    ;; set condition!
    :cond #'texmathp ; expand only while in math
    "supp" "\\supp"
    "On" "O(n)"
    "O1" "O(1)"
    "Olog" "O(\\log n)"
    "Olon" "O(n \\log n)"
    ;; bind to functions!
    "Sum" (lambda () (interactive)
            (yas-expand-snippet "\\sum_{$1}^{$2} $0"))
    "Span" (lambda () (interactive)
             (yas-expand-snippet "\\Span($1)$0"))
    ;; add accent snippets
    :cond #'laas-object-on-left-condition
    "qq" (lambda () (interactive) (laas-wrap-previous-object "sqrt"))))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package! md-org)

(use-package! evil-pinyin
  :init
  (setq-default evil-pinyin-scheme 'simplified-xiaohe-all)
  :config
  (global-evil-pinyin-mode))

(setq reftex-default-bibliography '("~/bib/Papers.bib"))
(setq org-cite-global-bibliography '("~/bib/Papers.bib"))

(setq +latex-viewers '(skim))


(setq org-latex-src-block-backend 'minted)


(setq TeX-engine 'xetex)
(setq citar-bibliography '("~/bib/Papers.bib"))
(setq citar-library-paths '("/Volumes/PortableSSD/zotero/storage"))
(setq evil-snipe-scope 'visible)
(setq ignored-local-variable-values
      '((ssh-deploy-on-explicit-save . 1)
        (ssh-deploy-root-remote . "/ssh:user@server:/remote/project/")
        (ssh-deploy-root-local . "/local/path/to/project/")))
(setq org-agenda-files
      '("/Users/xiaobai/org/" "/Users/xiaobai/org/roam/"
        "/Users/xiaobai/org/roam/projects/"))
(setq org-cite-csl-styles-dir "/Volumes/PortableSSD/zotero/styles")
(setq org-export-with-toc nil)
(setq org-file-apps
      '((remote . emacs) (auto-mode . emacs) (directory . emacs)
        ("\\.mm\\'" . default) ("\\.x?html?\\'" . default) ("\\.pdf\\'" . emacs)))
(setq org-highlight-latex-and-related '(native))
(setq org-latex-bib-compiler "biber")
(setq org-latex-classes
      '(("cusart" "\\documentclass{custom}\12\\usepackage{custom}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("beamer" "\\documentclass[presentation]{beamer}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
        ("article" "\\documentclass[UTF8,11pt,scheme=chinese,fontset=mac]{ctexart}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("report" "\\documentclass[UTF8,11pt,scheme=chinese,fontset=mac]{ctexrep}"
         ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
        ("book" "\\documentclass[UTF8,11pt,scheme=chinese,fontset=mac]{ctexbook}"
         ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
(setq org-latex-compiler "xelatex")
(setq org-latex-default-packages-alist
      '(("" "amsmath" t ("lualatex" "xelatex"))
        ("" "fontspec" nil ("lualatex" "xelatex"))
        ("AUTO" "inputenc" t ("pdflatex")) ("T1" "fontenc" t ("pdflatex"))
        ("" "graphicx" t nil) ("" "longtable" nil nil) ("" "wrapfig" nil nil)
        ("" "rotating" nil nil) ("normalem" "ulem" t nil)
        ("" "amsmath" t ("pdflatex")) ("" "amssymb" t ("pdflatex"))
        ("" "capt-of" nil nil) ("" "enumitem" nil nil) ("" "hyperref" nil nil)))
(setq org-latex-packages-alist
      '(("" "listings" nil nil) ("" "amssymb" nil nil) ("" "amsfonts" nil nil)
        ("" "mathtools" nil nil) ("" "booktabs" nil nil) ("" "minted" nil nil)))
(setq org-latex-hyperref-template
      "\\hypersetup{\12 pdfauthor={%a},\12 pdftitle={%t},\12 pdfkeywords={%k},\12 pdfsubject={%d},\12 pdfcreator={%c}, \12 pdflang={Chinese},\12 bookmarks=true,\12 bookmarksopen=true,\12 colorlinks=true,\12 linkcolor=black,\12 urlcolor=blue,\12 citecolor=blue,\12 pdfborder={0,0,0}\12}\12")
(setq org-latex-tables-booktabs t)
(setq org-log-done 'time)
(setq org-roam-capture-templates
      '(("d" "default" plain "%?" :target
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\12")
         :unnarrowed t)
        ("p" "project" plain "%?" :target
         (file+head "projects/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
         :unnarrowed t)))
(setq org-startup-with-latex-preview nil)
(setq tex-bibtex-command "biber")
(setq org-export-headline-levels 5)
(setq global-auto-revert-mode t)
(setq corfu-preview-current t)
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-file-type 'weekly)
(setq preview-image-type 'dvipng)

(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/opt/homebrew/bin/fish")
(setq-default explicit-shell-file-name "/opt/homebrew/bin/fish")
(after! corfu
  :config
  (setq corfu-preselect 'first)
  )
(setq +corfu-want-tab-prefer-expand-snippets 't)
