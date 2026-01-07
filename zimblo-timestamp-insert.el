(defun time-stamp-insert ()
  "Insert a time stamp and update it."
  (interactive)
  (goto-char (point-min)) ;; ehh
  (insert "Time-stamp: <> \n") 
  (time-stamp)
  )
