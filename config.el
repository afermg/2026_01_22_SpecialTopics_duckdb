;; Config necessary to run 'sql' using duckdb. This helps with the linting when exporting to Hugo
(use-package ob-duckdb
  :straight (:host github :repo "gggion/ob-duckdb")
  :after org
  :config
  (defalias 'org-babel-execute:sql 'org-babel-execute:duckdb) ;; Allows linting after export
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages '((duckdb . t)))))

(setq org-latex-compiler "xelatex")
(setq latex-run-command "xelatex")
(setq org-latex-pdf-process
      '("latexmk -pdflatex='xelatex -shell-escape -interaction nonstopmode ' -shell-escape -pdf -f %f "
        "latexmk -pdflatex='xelatex -interaction -shell-escape nonstopmode ' -shell-escape -pdf -f %f "
        "latexmk -pdflatex='xelatex -shell-escape -interaction nonstopmode ' -shell-escape -pdf -f %f "))

(setq org-latex-prefer-user-labels t
      org-latex-caption-above nil
      ;; org-latex-listings 'minted
      org-latex-listings nil
      )


;;Colours
(add-to-list 'org-latex-packages-alist '("" "minted" nil))
(setq org-latex-minted-options nil)
(setq org-latex-src-block-backend 'minted)

(add-to-list 'org-latex-classes
             '("beamerposter"
               "\\documentclass[final]{beamer}
            \\usepackage[T1]{fontenc}
            \\usepackage{lmodern}
            \\usepackage[size=custom,width=84.1,height=118.9,scale=1.0]{beamerposter}  
            \\usepackage{graphicx}
            \\usepackage{booktabs}
            \\usepackage{tikz}
            \\usepackage{pgfplots}
            \\pgfplotsset{compat=1.18}
            \\usepackage{anyfontsize}
            [NO-DEFAULT-PACKAGES]"))
