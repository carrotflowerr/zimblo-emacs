(defun zimblo/copy-pwd ()
  (interactive)
  (kill-new (expand-file-name default-directory))
  )
