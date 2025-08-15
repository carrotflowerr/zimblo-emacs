;; awesome
(hippie-expand)

;;tabs
C-x t 2
(tab-bar-new)

;; info files
C-h i m 

C-x * q
(calc-dispatch)

C-x z
(repeat)

;; goes to last mark (selection)
C-u C-SPC
(push-mark) ?

;; bookmark keys
c-x r m :: (bookmark-set)
c-x r b :: (bookmark-jump)

;; buffer only grep
(occur)

;; if you get weird package install errors:
(package-refresh-contents)


;; M-;
(comment-dwim)


;; C-M-f
;; C-M-b
;; jump between parens and quotes
;; like % in vim
(foward-sexp)

;; C-x 0
(delete-window)


;; zoom
C-x C-=

;; c-$(num) adds c-u

;; M-e
(forward-sentence)

;; Encrypt file
;; maybe rename to gpg or encrypt
(epa-encrypt-file)

;; Available key binds
(free-keys)

;; M-()
(insert-parentheses)
;; this for quotes would be nice
;; open new window
(make-frame)

;; Macro commands

;; enter macro editor
;; (C-x) (C-e)
(kmacro-edit-macro)

;; M-y clipboard

;; Keyboard Macro Editor.  Press C-c C-c to finish; press C-x k RET to cancel.
;; Original keys: C-x SPC > 2*C-f C-SPC 3*M-f M-w C-x M-b C-s C-y RET

(last-kbd-macro)
(insert-kbd-macro)
