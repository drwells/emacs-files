(defun matlab--align-continuation-right (line)
  "Align the ... on the end of a string."
  ; TODO make sure that this part is valid.
    (let ((index (string-match "\\.\\.\\.\\s-*$"
                               (replace-regexp-in-string " *\\.\\.\\.$" "..." line))))
      (cond
       ((eq index nil) line)
       (t (concat (substring line 0 index)
                  ; add appropriate spaces (or none if line too long)
                  (make-string (max 0 (- fill-column index 3)) ? )
                  "...")))))

(defun matlab-align-continuation-right-buffer ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward-regexp "\\.\\.\\.\\s-*$" (point-max) t)
      (let ((new-content
             (matlab--align-continuation-right
                      (buffer-substring-no-properties (line-beginning-position)
                                                      (line-end-position)))))
        (progn
          (delete-region (line-beginning-position) (line-end-position))
          (goto-char (line-beginning-position))
          (insert new-content)
          nil)))))

; run it before saving.
(add-hook 'before-save-hook
          (lambda () (matlab-align-continuation-right-buffer)) nil t)
