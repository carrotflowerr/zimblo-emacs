;; Caffeine timespan calculator -*- lexical-binding: t; -*-
;; Written by: Zimblo (github.org/carrotflowerr)

;; Uses the following equation:
;; C(t) = C0 * (1/2)^(t/hl)
;; Where:
;; C0 = dose
;; t = time (hr)
;; hl = half-life. Avg = 5-6


(defun dose-to-cup (rem)
  (let ((cup-cont 80))  ;; average cup is 80mg
    (/ rem cup-cont))
  )



(defun mg-timespan ()

  (setq hl 5)

  (setq c0 (read-number "dose:"))
  (setq time (read-number "time since dose:"))

  (setq exp (/ (float time) hl))
  (setq rem (* c0 (expt 0.5 exp)))

  ;;(insert (float rem))
  ;; (message "Remaining caffeine: %.2f mg" rem)
  ;; (message "Equivalent cups: %.2f" (dose-to-cup rem))
  (message "Remaining caffeine: %.2f mg (≈ %.2f cups)" rem (dose-to-cup rem))
)

(mg-timespan)
