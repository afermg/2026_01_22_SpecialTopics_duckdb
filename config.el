;; Config necessary to run 'sql' using duckdb. This helps with the linting when exporting to Hugo
(use-package ob-duckdb
  :straight (:host github :repo "gggion/ob-duckdb")
  :after org
  :config
  (defalias 'org-babel-execute:sql 'org-babel-execute:duckdb) ;; Allows linting after export
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages '((duckdb . t)))))
