;; -*- lexical-binding: t; -*-
(defun auto-fill-buffer ()
  "Apply auto-fill-mode to current buffer."
  (interactive)
  (auto-fill-mode 1)
  (fill-region (point-min) (point-max)))
