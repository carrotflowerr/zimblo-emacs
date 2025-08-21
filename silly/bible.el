(defun bible ()
  "Open the bible."
  (interactive)
  (find-file "~/.emacs.d/eww/kjv.txt")
  )

(global-set-key (kbd "C-c M-b") 'bible)

;; dont use these
(defalias 'bible-save-quote
   (kmacro "C-x SPC > a C-f C-f C-S-n M-w C-x C-f . e m a <tab> b i b l <tab> <return> C-y <return> <return> C-x C-s"))

;; Open place of random quote (must be on dash)
(defalias 'bible-goto-quote
  (kmacro "C-x SPC > a C-f C-f C-SPC M-f M-f M-f M-w C-c M-b C-s C-y <return>")
  )
