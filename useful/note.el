;; Zimblo’s (emacs) note script  -*- lexical-binding: t; -*-
;; it’s like denote but without any features
(defvar tmp-note-dir "~/.note/"
  "Directory to save temporary notes.")

(defun tmp-save-note ()
  "Prompt for a new name in tmp-note-dir; default to current tmp file name."
  (interactive)
  (let* ((default-name (file-name-nondirectory (buffer-file-name)))
         (dir (expand-file-name tmp-note-dir))
         (input-name (read-string (format "Save as (in %s, default: %s): " dir default-name)))
         (final-name (if (string-empty-p input-name) default-name input-name))
         (fullPath (expand-file-name final-name dir)))
    (make-directory dir t)
    (write-file fullPath)
    (message "Buffer saved to: %s" fullPath)
    (kill-buffer)))


(defun tmp-new-note ()
  "Create and open tmp file. requires mktemp."
  (interactive)
  (let
      ((tmpFilename
        (string-trim
         (shell-command-to-string "mktemp"))))
    (find-file tmpFilename))
  (local-set-key
   (kbd "C-x C-s") #'tmp-save-note)
  )
