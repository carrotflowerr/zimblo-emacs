;; Jumps to the middle of the line
(defun zimblo/move-to-middle ()
  (interactive)
  (let* ((begin (line-beginning-position))
         (end (line-end-position))
         (middle (/ (+ end begin) 2)))
    (goto-char middle)))

(global-set-key (kbd "C-c m") 'zimblo/move-to-middle)
