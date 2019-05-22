(defun scheme-send-buffer ()
  "Send the current buffer to the inferior Scheme process."
  (interactive)
  (save-buffer)
  (comint-send-string (scheme-proc)
                      (concat "(load \"" (buffer-file-name) "\")\n")))
