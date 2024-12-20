#lang racket


(require math/statistics)  ;; Import math functions

;; Function to calculate Euclidean distance between two points
(define (distance x1 y1 x2 y2)
  (sqrt (+ (sqr (- x2 x1))
           (sqr (- y2 y1)))))

;; Function to read lines from a file and collect them as a list of coordinates
(define (next-line-it in-port)
  (let loop ((line (read-line in-port 'any))  ;; Initialize the loop with the first line
             (coords '()))  ;; Start with an empty list of coordinates
    (cond
      ((eof-object? line) (reverse coords))  ;; When reaching the end of the file, return the coordinates
      (else
       (let ((point (map string->number (string-split line))))  ;; Split and convert to numbers
         (loop (read-line in-port 'any) (cons point coords)))))))  ;; Recursively add points to the list

;; Function to calculate and print the distances between consecutive points
(define (calculate-distances coords)
  (let loop ((prev-point (first coords))
             (remaining (rest coords))
             (total-distance 0))
    (if (null? remaining)  ;; If there are no more points, return the total distance
        total-distance
        (let* ((next-point (first remaining))
               (dist (distance (first prev-point) (second prev-point)
                               (first next-point) (second next-point))))
          (displayln (format "Distance: ~a" dist))  ;; Print the distance
          (loop next-point (rest remaining) (+ total-distance dist))))))  ;; Continue with the next point

;; Main function to read the file and calculate distances
(define (main file)
  (define coords
    (call-with-input-file file  ;; Open the file and read coordinates
      (lambda (in-port)
        (next-line-it in-port))))
  (calculate-distances coords))  ;; Pass coordinates to the distance calculation function

;; File with coordinates
(define file "ej_pts_02.txt")

;; Run the program
(main file)