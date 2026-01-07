;;; runic-mode.el --- Major mode for typing English Runes based on custom layout  -*- lexical-binding: t; -*-

;; Author: Gemini, Xah-lee
;; Version: 1.0


(defun runic-translate-region-or-line (Begin End ToLatinQ)
  "Translate between Latin characters (lowercase) and Anglo-Saxon Futhorc runes.
Uses the custom keymap defined in `runic-mode.el`.

If `universal-argument` (C-u) is called first (ToLatinQ is non-nil), 
translates from Runic to Latin. Otherwise, translates from Latin to Runic.
Note: Input Latin text is converted to lowercase before translation.

Structure adapted from xah-convert-latin-to-rune.
Created: 2025-11-21"
  (interactive
   (if (region-active-p)
       (list (region-beginning) (region-end) current-prefix-arg)
     (list (line-beginning-position) (line-end-position) current-prefix-arg)))
  (let (xuseMap xtoLatin xtoRune)

    ;; 1. Anglo-Saxon Futhorc map: [[Rune Latin-Char] ...]
    ;; Uses two-element vectors to match the original function's style.
    ;; This map is derived from the custom keyboard layout defined in runic-mode.el
    (setq xtoLatin
          [
            ;; R1 (QWERTY)
            ["ᛜ" "g"] ["ᚹ" "w"] ["ᛖ" "e"] ["ᚱ" "r"] ["ᛏ" "t"]
            ["ᛇ" "i"] ["ᚢ" "u"] ["ᛁ" "i"] ["ᛟ" "o"] ["ᛈ" "p"]
            ;; R2 (ASDF)
            ["ᚨ" "a"] ["ᛋ" "s"] ["ᛞ" "d"] ["ᚠ" "f"] ["ᚷ" "g"]
            ["ᚻ" "h"] ["ᚾ" "n"] ["ᚲ" "k"] ["ᛚ" "l"] ["ᛣ" "c"] ; ᛣ (Calc)
            ;; R3 (ZXCV)
            ["ᛉ" "z"] ["ᚣ" "y"] ["ᚳ" "k"] ["ᚡ" "v"] ["ᛒ" "b"]
            ["ᛅ" "a"] ["ᛗ" "m"]
          ])

    ;; 2. Latin-to-Runic map: derived by reversing xtoLatin. [[Latin-Char Rune] ...]
    (setq xtoRune (mapcar (lambda (xx) (vector (aref xx 1) (aref xx 0))) xtoLatin))

    ;; 3. Select map based on `ToLatinQ` argument (C-u prefix)
    (setq xuseMap (if ToLatinQ xtoLatin xtoRune))

    (save-excursion
      (save-restriction
        (narrow-to-region Begin End)

        (let ((map-from "")
              (map-to "")
              (char-count 0))

          ;; For Latin-to-Runic conversion, convert the input text to lowercase first.
          ;; This is ignored if translating Runic to Latin.
          (when (not ToLatinQ)
            (downcase-region (point-min) (point-max)))

          ;; Build the 'from' and 'to' strings for the highly efficient translate-chars
          (mapc
           (lambda (pair)
             ;; pair is a vector: [Rune Latin] or [Latin Rune]
             (setq map-from (concat map-from (aref pair 0)))
             (setq map-to (concat map-to (aref pair 1))))
           xuseMap)

          ;; Perform the character translation over the narrowed region
          (setq char-count (translate-chars map-from map-to (point-min) (point-max)))

          (message "%d characters translated (%s)."
                   char-count
                   (if ToLatinQ "Rune to Latin" "Latin to Rune")))))))



(defvar runic-mode-map
  (let ((map (make-sparse-keymap)))
    ;; Row 1 (QWERTY)
    (define-key map (kbd "q") (lambda () (interactive) (insert "ᛜ"))) ; Ingwaz
    (define-key map (kbd "Q") (lambda () (interactive) (insert "ᛜ")))
    (define-key map (kbd "w") (lambda () (interactive) (insert "ᚹ"))) ; Wunjo
    (define-key map (kbd "W") (lambda () (interactive) (insert "ᚹ")))
    (define-key map (kbd "e") (lambda () (interactive) (insert "ᛖ"))) ; Ehwaz
    (define-key map (kbd "E") (lambda () (interactive) (insert "ᛖ")))
    (define-key map (kbd "r") (lambda () (interactive) (insert "ᚱ"))) ; Raido
    (define-key map (kbd "R") (lambda () (interactive) (insert "ᚱ")))
    (define-key map (kbd "t") (lambda () (interactive) (insert "ᛏ"))) ; Tiwaz
    (define-key map (kbd "T") (lambda () (interactive) (insert "ᛏ")))
    (define-key map (kbd "y") (lambda () (interactive) (insert "ᛇ"))) ; Eihwaz
    (define-key map (kbd "Y") (lambda () (interactive) (insert "ᛇ")))
    (define-key map (kbd "u") (lambda () (interactive) (insert "ᚢ"))) ; Uruz
    (define-key map (kbd "U") (lambda () (interactive) (insert "ᚢ")))
    (define-key map (kbd "i") (lambda () (interactive) (insert "ᛁ"))) ; Isa
    (define-key map (kbd "I") (lambda () (interactive) (insert "ᛁ")))
    (define-key map (kbd "o") (lambda () (interactive) (insert "ᛟ"))) ; Othala
    (define-key map (kbd "O") (lambda () (interactive) (insert "ᛟ")))
    (define-key map (kbd "p") (lambda () (interactive) (insert "ᛈ"))) ; Peorth
    (define-key map (kbd "P") (lambda () (interactive) (insert "ᛈ")))

    ;; Row 2 (ASDF)
    (define-key map (kbd "a") (lambda () (interactive) (insert "ᚨ"))) ; Ansuz
    (define-key map (kbd "A") (lambda () (interactive) (insert "ᚨ")))
    (define-key map (kbd "s") (lambda () (interactive) (insert "ᛋ"))) ; Sowilo
    (define-key map (kbd "S") (lambda () (interactive) (insert "ᛋ")))
    (define-key map (kbd "d") (lambda () (interactive) (insert "ᛞ"))) ; Dagaz
    (define-key map (kbd "D") (lambda () (interactive) (insert "ᛞ")))
    (define-key map (kbd "f") (lambda () (interactive) (insert "ᚠ"))) ; Fehu
    (define-key map (kbd "F") (lambda () (interactive) (insert "ᚠ")))
    (define-key map (kbd "g") (lambda () (interactive) (insert "ᚷ"))) ; Gebo
    (define-key map (kbd "G") (lambda () (interactive) (insert "ᚷ")))
    (define-key map (kbd "h") (lambda () (interactive) (insert "ᚻ"))) ; Hagalaz
    (define-key map (kbd "H") (lambda () (interactive) (insert "ᚻ")))
    (define-key map (kbd "j") (lambda () (interactive) (insert "ᚾ"))) ; Naudiz (Visual match)
    (define-key map (kbd "J") (lambda () (interactive) (insert "ᚾ")))
    (define-key map (kbd "k") (lambda () (interactive) (insert "ᚲ"))) ; Kauna
    (define-key map (kbd "K") (lambda () (interactive) (insert "ᚲ")))
    (define-key map (kbd "l") (lambda () (interactive) (insert "ᛚ"))) ; Laguz
    (define-key map (kbd "L") (lambda () (interactive) (insert "ᛚ")))

    ;; Row 3 (ZXCV)
    (define-key map (kbd "z") (lambda () (interactive) (insert "ᛉ"))) ; Algiz
    (define-key map (kbd "Z") (lambda () (interactive) (insert "ᛉ")))
    (define-key map (kbd "x") (lambda () (interactive) (insert "ᚣ"))) ; Yr
    (define-key map (kbd "X") (lambda () (interactive) (insert "ᚣ")))
    (define-key map (kbd "c") (lambda () (interactive) (insert "ᚳ"))) ; Cen
    (define-key map (kbd "C") (lambda () (interactive) (insert "ᚳ")))
    (define-key map (kbd "v") (lambda () (interactive) (insert "ᚡ"))) ; Voiced F/V variant
    (define-key map (kbd "V") (lambda () (interactive) (insert "ᚡ")))
    (define-key map (kbd "b") (lambda () (interactive) (insert "ᛒ"))) ; Berkanan
    (define-key map (kbd "B") (lambda () (interactive) (insert "ᛒ")))
    (define-key map (kbd "n") (lambda () (interactive) (insert "ᛅ"))) ; Ar (Visual match)
    (define-key map (kbd "N") (lambda () (interactive) (insert "ᛅ")))
    (define-key map (kbd "m") (lambda () (interactive) (insert "ᛗ"))) ; Mannaz
    (define-key map (kbd "M") (lambda () (interactive) (insert "ᛗ")))
    map)
  "Keymap for Runic Mode.")

;;;###autoload
(define-derived-mode runic-mode text-mode "Runic"
  "Major mode for editing text in English Runes (Anglo-Saxon Futhorc).
  
  Based on the semi-phonetic layout:
  Q=ᛜ W=ᚹ E=ᛖ R=ᚱ T=ᛏ Y=ᛇ U=ᚢ I=ᛁ O=ᛟ P=ᛈ
  A=ᚨ S=ᛋ D=ᛞ F=ᚠ G=ᚷ H=ᚻ J=ᚾ K=ᚲ L=ᛚ
  Z=ᛉ X=ᚣ C=ᚳ V=ᚡ B=ᛒ N=ᛅ M=ᛗ"
  
  ;; Clear the variable that controls the mode-line display
  ;; to simply show "Runic".
  )

(provide 'runic-mode)
