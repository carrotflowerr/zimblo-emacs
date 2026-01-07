;; -*- lexical-binding: t; -*-
;; suggested keybinds
;; (global-set-key (kbd "C-c s") 'tmp) 
;; (global-set-key (kbd "C-c C-s") 'tmp-copy) 

(defvar tmp-note-dir "~/.note/"
  "Directory to save temporary notes.")

(defun tmp--ignore-modified-on-kill ()
  "Force the buffer to be marked as unmodified so Emacs doesn't prompt on kill."
  (set-buffer-modified-p nil)
  t)

(defun tmp-setup-buffer ()
  "Apply temporary buffer settings to the current buffer."
  (lisp-mode)
  (setq-local buffer-offer-save nil)
  (set-buffer-modified-p nil)
  (add-hook 'kill-buffer-query-functions #'tmp--ignore-modified-on-kill nil t))

(defun tmp-create()
  "Create tmp file."
  (interactive)
  (let ((tmpFilename (string-trim (shell-command-to-string "mktemp"))))
    tmpFilename))

(defun tmp()
  "Open tmp file."
  (interactive)
  (let ((tmpFilename (tmp-create)))
    (find-file tmpFilename)
    (tmp-setup-buffer)))

(defun tmp-copy ()
  "Copy buffer/region to a tmp file"
  (interactive)
  (let ((contents (if (use-region-p)
                      (buffer-substring (region-beginning) (region-end))
                    (buffer-string)))
        (tmpFilename (tmp-create)))
    (find-file tmpFilename)
    (insert contents)
    (tmp-setup-buffer)))

(defun tmp-save ()
  "Save the current buffer to the note directory."
  (interactive)
  (let* ((dir tmp-note-dir)
         (target-path (expand-file-name (file-name-nondirectory (buffer-name)) dir)))
    (make-directory dir t)
    (write-file target-path)
    ;; Restore normal behavior: Allow saving prompts now that it's a permanent note
    (setq-local buffer-offer-save t)
    (remove-hook 'kill-buffer-query-functions #'tmp--ignore-modified-on-kill t)))
