(in-package #:cl-https-everywhere)

(defun compile-rulesets (file)
  (lret ((dict (dict)))
    (dolist (ruleset (compile-rulesets-file file))
      (unless (ruleset.disabled? ruleset)
        (dolist (target (ruleset.targets ruleset))
          (let ((target (string-downcase target)))
            (push ruleset (gethash target dict))))))))

(loom:deflang/expander rulesets-file (source)
  (compile-rulesets source)
  :extension "xml")
