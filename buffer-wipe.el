(defun buffer-wipe()
  "Kill all buffers"
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows)
  )
