(in-package :med)

(defclass buffer-stream (sys.gray::fundamental-character-output-stream)
  ((buffer :initarg :buffer :reader buffer-stream-buffer)))

(defmethod sys.gray::stream-advance-to-column ((stream buffer-stream) column)
   (let ((buffer (buffer-stream-buffer buffer-stream))
     (line (point-line (buffer-point buffer))))
     (setf (line-charpos line) column)))

(defmethod sys.gray::stream-line-column ((stream buffer-stream))
   (let ((buffer (buffer-stream-buffer buffer-stream))
     (line (point-line (buffer-point buffer))))
     (line-charpos line)))

(defmethod sys.gray::stream-line-length ((stream buffer-stream))
   (let ((buffer (buffer-stream-buffer buffer-stream))
     (line (point-line (buffer-point buffer))))
     (length (line-data line))))

(defmethod sys.gray::stream-start-line-p ((stream buffer-stream))
   (let ((buffer (buffer-stream-buffer buffer-stream))
     (line (point-line (buffer-point buffer))))
     (= 0 (line-charpos line))))

(defmethod sys.gray::stream-fresh-line ((stream buffer-stream))
  (let ((buffer (buffer-stream-buffer stream)))
    (save-excursion (buffer)
      (move-end-of-buffer buffer)
      (insert buffer #\Newline))))

(defmethod sys.gray::stream-terpri ((stream buffer-stream))
  (let ((buffer (buffer-stream-buffer stream)))
    (save-excursion (buffer)
      (move-end-of-buffer buffer)
      (insert buffer #\Newline))))

(defmethod sys.gray::stream-write-char ((stream buffer-stream) char)
  (let ((buffer (buffer-stream-buffer stream)))
    (save-excursion (buffer)
      (move-end-of-buffer buffer)
      (insert buffer char))))

(defmethod sys.gray::stream-write-string ((stream buffer-stream) string)
  (let ((buffer (buffer-stream-buffer stream)))
    (save-excursion (buffer)
      (move-end-of-buffer buffer)
      (insert buffer string))))
