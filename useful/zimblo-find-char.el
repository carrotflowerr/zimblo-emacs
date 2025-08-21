;;;  -*- lexical-binding: t -*-
;; Based on:  evil-commands.el
;; Author: Zimblo (github.com/carrotflowerr)
;; This file is NOT part of GNU Emacs.

(defun zimblo-find-char (count char)
  "Move to the COUNT'th occurrence of CHAR on the current line (or visual line).
Negative COUNT searches backward. Signal error if no room to search."
  (interactive "p\ncFind char: ")
  (let* ((cnt (or count 1))
         (orig (point))
         (fwd (> cnt 0))
         (visual visual-line-mode)
         (case-fold-search nil)
         (limit (cond
                 ((and fwd visual) (save-excursion (end-of-visual-line) (point)))
                 (fwd (line-end-position))
                 ((and (not fwd) visual) (save-excursion (beginning-of-visual-line) (point)))
                 (t (line-beginning-position)))))
    (if fwd
        (progn
          (when (<= limit orig) (user-error "Can't find `%c'" char))
          (goto-char (min (1+ orig) (point-max)))
          (unless (search-forward (char-to-string char) limit t cnt)
            (user-error "Can't find `%c'" char))
          (backward-char))
      ;; backward search
      (when (>= limit orig) (user-error "Can't find `%c'" char))
      (goto-char (max (1- orig) (point-min)))
      (unless (search-backward (char-to-string char) limit t (abs cnt))
        (user-error "Can't find `%c'" char)))))

(defun zimblo-find-char-backward (count char)
  "call `zimblo-find-char' with negative COUNT."
  (interactive "p\ncFind char backward: ")
  (zimblo-find-char (- (or count 1)) char))
