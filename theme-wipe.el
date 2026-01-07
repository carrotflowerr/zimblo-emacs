(defun theme-wipe ()
  (mapc (lambda (face)
          (when (facep face)
            (set-face-attribute face nil
                                :foreground nil
                                :background nil
                                :inherit 'default)))
        (face-list))
  )



